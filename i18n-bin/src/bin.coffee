> @w5/read
  @w5/snake
  @w5/uridir
  @w5/write
  @w5/utf8/utf8e.js
  @w5/u8 > u8merge
  @w5/yml/Yml.js
  radix-64:Radia64
  fs > existsSync readFileSync
  path > join dirname basename resolve
  @8n/lang:LANG

# {encodeInt} = radix64()

cmp = (a,b)=>
  a[1] - b[1]

{decodeToInt} = Radia64()

outFp = (dir,name)=>
  join dir, name

outJs = (dir, name)=>
  join dir, name+'.js'

code_js = (dir, js_dir, lang)=>
  code_fp = outJs js_dir, 'code'

  code = if existsSync code_fp then await import(resolve code_fp) else {}

  id = 0
  for [k,v] from Object.entries code
    if v >= id
      id = v + 1

  out = []

  k_code = []
  for [key,v] from Object.entries lang
    k = snake(key).toLocaleUpperCase()
    i = code[k]

    # 0 是有效的id
    if i == undefined
      i = id++

    k_code.push [key,i]
    out.push [
      k
      i
    ]

  out.sort cmp
  k_code.sort cmp

  for [k,v],pos in out
    out[pos] = "#{k}=#{v}"

  write(code_fp, 'export const '+out.join(',')+';')
  return k_code

push = (li, n, pre)=>
  {length} = li
  if length
    li.push n - pre - 1
  else
    li.push n
  return

export default (dir, js_dir, bin_dir, default_lang='en')=>
  yml = Yml(dir)
  lang = yml[default_lang]

  li = await code_js(dir, js_dir, lang)

  pos_li = []
  pre_pos = 0
  id_li = []

  pre_id = -1
  + pre_push_id
  pre_pos = -1

  for [i,id],pos in li
    if id != pre_id+1
      push pos_li, pos, pre_pos
      push id_li, id, pre_push_id
      pre_pos = pos
      pre_push_id = id
    pre_id = id

  pos_id_li = pos_li.concat(id_li)

  var_js = outJs(js_dir, 'var')
  if existsSync var_js
    {ver} = await import(resolve var_js)
  else
    ver = '-'

  write(
    var_js
    """\
    export const ver = '#{ver}' // #{decodeToInt ver}
    export const posId = #{JSON.stringify(pos_id_li)}
    """
  )

  onMount = outJs js_dir, 'onMount'
  pkg = basename(dirname dir)
  if not existsSync onMount
    write(
      onMount
      """\
      import {ver,posId} from "./var.js"
      import i18n from "../../_/i18n.js"
      import CDN from "../../_/CDN.js"
      import lang from "../../_/lang.js"
      const r = i18n.#{pkg}(ver, posId,()=>CDN()+'#{pkg}/'+ver+'/'+lang())
      export const I18N = r[0];
      export default r[1];
      """
    )

  for [lang] from LANG
    t = []
    d = yml[lang]
    for [key] in li
      t.push(
        utf8e(
          d[key].replace(
            /<br\s+([^\/>]+)>/g
            (_,s)=>
              '${'+s+'}'
          )
        )
      )
      t.push new Uint8Array(1)
    bin = u8merge(...t)[..-2]
    write(
      join bin_dir, lang
      bin
    )

  return
