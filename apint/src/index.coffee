#!/usr/bin/env coffee

> @3-/walk > walkRel
  @3-/extract > extract
  @3-/read
  @3-/write
  @3-/nt/dumps.js
  @3-/camel/Camel.js
  zx/globals:
  path > join basename dirname
  fs > readdirSync existsSync

removeEnd = (s)=>
  s = s.trim()
  if s.endsWith ','
    return s.slice(0,-1)
  s

splitTrim = (i)=>
  i.split(',').map (i)=>i.trim()

json_args = (code)=>
  end = code.lastIndexOf(')>')
  code = code.slice(0,end)
  [name,type] = code.split(':::jarg::Json<(')

  name = splitTrim name
  name[0] = name[0].slice(1).trimStart()
  if name.at(-1) == ')'
    name.pop()

  len = name.length-1
  if len >= 0
    loop
      t = name[len]
      if t.endsWith ')'
        name[len] = t.slice(0,-1)
      else
        break

  type = splitTrim type

  name.map (i,p)=>
    [
      i
      type[p]
    ]

return_type = (code)=>
  p = code.indexOf('Ok(api::')
  if p<0
    p = code.indexOf('ok!(api::')
    if p < 0
      p = code.indexOf('api::')
    else
      p += 4
  else
    p += 3

  if ~p
    p += 5
    code = code.slice(p)
    for i, end in code
      if '>{ \n,='.includes i
        return code.slice(0,end).trim()
  '()'

hasCaptcha = (args)=>
  r = []
  + has
  for i from args.split(',')
    if i.endsWith(':Captcha')
      if i.startsWith('_:')
        has = true
        continue
    r.push(i)

  return [r.join(','),has]

async_export = (def)=>
  'pub async fn '+ def + '('

args_body = (def, code)=>
  def = async_export def
  begin = code.indexOf def
  if ~begin
    begin += def.length
    end = code.indexOf '\n}', begin
    if ~end
      code = code.slice(begin,end)
      for s from ['-> ::re::Result<','-> re::Result<' ]
        p = code.indexOf(s)
        if ~p
          args = code.slice(0,p)
          args = args.slice(0,args.lastIndexOf(')'))
          body = code.slice(p+s.length)
          body = body.slice(body.indexOf('{')+1)
          return [args, body]
  return

api = (url, code)=>
  + post_args, get
  r = args_body('post', code)
  if r
    [args, body] = r
    args = args.replaceAll('\n',' ').replace(/\s+/g,' ').trim().replace(
      /\s*[:,\(\)]\s*/g
      (m)=>
        m.trim()

    ).replace(/,$/,'').replaceAll(',)',')')
    rt = return_type(body)
    [args,has_captcha] = hasCaptcha(args)
    post_args = []
    pos = args.indexOf('::jarg::Json(')
    if pos>=0
      json = args.slice(pos+13)
      args = args.slice(0,pos).replace(/,$/,'')
      a =  json_args(json)
      json = a.map(
        ([name,type])=>
          post_args.push "#{name}:#{type}"
          "  #{name} : #{type}"
      ).join('\n')
    else
      pos = args.indexOf(':Option<::jarg::Json<')
      if pos > 0
        begin = args.lastIndexOf(',',pos)
        if begin < 0
          begin = 0
        else
          begin += 1
        type = args.slice(pos+22)
        type = type.slice(0,type.indexOf(')>>'))
        name = args.slice(begin, pos)
        post_args.push "#{name}:#{type}"
        json = "  #{name} : Option<#{type}>"

    tip = "#{url}(#{args}) -> #{rt}"
    if has_captcha
      tip = '🚧 '+tip
    if pos >= 0
      console.log json

    console.log '\n'+tip
    post_args = post_args.join(';')
    post_args += ('→' + rt)
    if has_captcha
      post_args = '🚧 '+post_args

  r = args_body('get', code)
  if r
    [args] = r
    p = args.indexOf 'Path('
    if ~ p
      p+=5
      args = args.slice(p, args.indexOf(')',p+1)).replaceAll('(','').split(',').map (i)=>i.trim()
      get = args
    else
      get = 0
  if (post_args != undefined) or get != undefined
    return [post_args, get]
  return

mod_rs = (dir)=>
  src = join dir, 'src'
  mod_li = []
  for i from readdirSync src
    if i.endsWith('.rs') and not i.startsWith('_')
      if i == 'lib.rs'
        continue
      code = read join src, i
      has_export = 0
      for method from ['get','post']
        if ~ code.indexOf(async_export(method))
          has_export = 1
          break
      if has_export
        mod_li.push i.slice(0,-3)
  urlmod = mod_li.map (m)=>"    pub mod #{m};"
  write(
    join src, '_mod.rs'
    """// GEN BY api.coffee ; DON'T EDIT
#[macro_export]
macro_rules! urlmod {
  () => {
#{urlmod.join('\n')}
  };
}"""
  )
  return

< out_mod_li = (out)=>
  r = []
  t = []
  mod = ''
  for i from out.split('\n')
    t.push i
    if i == '}'
      r.push [mod, t]
      t = []
      mod = ''
    else if i.startsWith('mod ') or i.startsWith('pub mod ')
      if i.endsWith('}')
        t.pop()
        continue
      i = i.slice(0,i.lastIndexOf('{')-1).trimEnd()
      mod = i.slice(i.lastIndexOf(' ')+1)

  return r


export expand = =>
  $.verbose = false
  out = await $"cargo expand --theme=none"
  $.verbose = true
  return out.stdout

export expand_gen = (base)=>
  gen_nt(
    await expand()
    base
  )

export default gen = (dir)=>
  mod_rs(dir)
  cd dir
  base = basename dir
  [
    api_nt
    import_li
    get_map
  ] = await expand_gen(
    base
  )
  write(
    join dir, 'api.nt'
    '# GEN BY srv/rust/sh/api.coffee . DON\'T EDIT !\n'+dumps(
      api_nt
    ).trim()+'\n'
  )
  mod = "#{basename(dirname dir)}_#{base}"
  return [
    mod
    if import_li.length > 0 then "pub use #{mod}::{#{import_li.join(', ')}};" else ''
    Object.keys(api_nt)
    get_map
  ]


< gen_nt = (out, base)=>
  import_li = []
  api_nt = {}
  get_map = {}
  map_li = [
    (url, i)=>
      api_nt[url] = i
      return
    (url, i)=>
      get_map[url] = i
      return
  ]

  merge = (url, code)=>
    r = api(url, code)
    if r
      for i, p in r
        if i != undefined
          map_li[p](url, i)
    return !!r

  for [mod, li] from out_mod_li out
    realm = mod
    if mod == base
      mod = ''
    else
      mod = Camel mod
    url = base + mod
    end = '\n}'
    li =  li.join('\n').split(end)
    if merge(url,  li.shift()+end)
      if realm
        import_li.push realm+' as '+url
      else
        import_li.push 'self as '+base

    for i from li
      i = i.trim()
      if i
        if merge(base, i+end)
          import_li.push 'self as '+base

  [
    api_nt
    import_li
    get_map
  ]


export scan = (root)=>
  for dir from readdirSync root
    if dir.startsWith '.'
      continue
    dir = join root, dir
    for i from readdirSync dir
      if i.startsWith '.'
        continue
      if existsSync join dir,i,'Cargo.toml'
        await gen join(dir,i)
  return
