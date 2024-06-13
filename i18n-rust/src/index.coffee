> @3-/redis/R.js
  @3-/write
  @3-/read
  @3-/nt/load.js
  @3-/u8/u8merge.js
  @3-/utf8/utf8e.js
  @3-/intbin > u64Bin
  @3-/lang/CODE.js
  @3-/snake > SNAKE
  path > join basename dirname
  fs > existsSync

const_bytes = (key)=>
  "pub const #{SNAKE key}: &[u8] = b#{JSON.stringify(key)};"

ignore = (i)=>
  i = basename(i)
  i.startsWith('.') or ['node_modules'].includes(i)

kv = (dir, file_li, lang_set)=>
  prefix = basename dirname dir
  for lang from lang_set
    pwd = join dir, lang
    o = {}
    i18n_nt = join pwd, 'i18n.nt'
    if existsSync i18n_nt
      for [k,v] from Object.entries load i18n_nt
        o[k] = v

    for fp from file_li
      md = read join pwd, fp
      md = md.replace(
        /<br\s+_([^\/>]+)_>/g
        (_,s)=>
          '${'+s+'}'
      ).trim()
      o[fp.slice(0,-3)] = md
    key = Buffer.from u8merge(
      utf8e(prefix+'I18n:')
      u64Bin CODE.indexOf(lang)
    )
    await R.hmset key, o
  return

i18nRs = (dir, file_li, lang_set)=>
  i18n = []
  for lang from lang_set
    pwd = join dir, lang
    i18n_nt = join pwd, 'i18n.nt'
    if existsSync i18n_nt
      keys = Object.keys load i18n_nt
      for key from keys
        i18n.push const_bytes key
    for fp from file_li
      i18n.push const_bytes fp.slice(0,-3)
    break


  if not i18n.length
    return

  project = dirname(dir)

  rs = [
    """
// gen by @3-/i18n-rust ; DON'T EDIT

use r::{
  fred::interfaces::{HashesInterface, RedisResult},
  R,
};

#{i18n.join("\n\n")}

#[macro_export]
macro_rules! throw {

  ($header:ident,$id:ident,$key:ident) => {{
    $crate::i18n::throw(&$header, stringify!($id), $crate::i18n::$key).await?;
    unreachable!()
  }};

  ($header:ident,$id:ident,$($key:ident),+) => {{
    $crate::i18n::throw_li(&$header, stringify!($id), &[
      $($crate::i18n::$key),+
    ]).await?;
    unreachable!()
  }};

}


""" + "::i18n::gen!(#{basename project});"
  ]

  outfp = join(project, 'src/i18n.rs')
  write(
    outfp
    rs.join('\n\n')
  )

  console.log outfp
  return

< (dir, file_li, to_from)=>
  lang_set = new Set
  for li from to_from
    for i from li
      lang_set.add i
  await Promise.all [
    i18nRs(dir, file_li, lang_set)
    kv(dir, file_li, lang_set)
  ]
  return
