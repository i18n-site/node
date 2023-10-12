> @w5/vite-conf/sveltePreprocess.js
  @w5/read

IMPORT_onMount = 1
IMPORT_onI18n = 2

IMPORT = {}

IMPORT[IMPORT_onMount] = 'import {onMount} from \'svelte\''
IMPORT[IMPORT_onI18n] = 'import onI18n from \'@8p/lang/onI18n.js\''


svelte = (txt)=>
  r = []

  + in_script, in_pug, script_line

  pug_i18n = new Set
  auto_import = new Set

  for line, pos in txt.split '\n'
    if in_script
      if line.startsWith '</script>'
        import_li = []
        for i from auto_import
          import_li.push IMPORT[i]
        if import_li.length
          r[script_line] = r[script_line]+import_li.join(';')
        in_script = false
      else
        if line.startsWith 'onMount '
          auto_import.add IMPORT_onMount
        if line.startsWith 'onI18n '
          for j from [IMPORT_onI18n, IMPORT_onMount]
            auto_import.add j
          line = 'onMount '+line
    else if in_pug
      if line.startsWith '</template>'
        in_pug = false
      else
        line = line.replace(
          /:>(.*)(\s|\))/g
          (_,s1,s2)=>
            pug_i18n.add s1
            ':'+s1+'$'+s2
        ).replace(
          /\s>([^\s]+)/g
          (_,s1)=>
            pug_i18n.add s1
            ' {@html '+s1+'$}'
        )
    else if line.startsWith '<script'
      in_script = true
      script_line = pos
    else if line.startsWith '<template'
      in_pug = true
    r.push line

  if pug_i18n.size and script_line != undefined
    js = []
    var_li = []
    dict_li = []

    if not r[script_line].endsWith('>')
      js.push ''

    for i from [IMPORT_onI18n, IMPORT_onMount]
      if not auto_import.has i
        js.push IMPORT[i]
    for i from pug_i18n
      var_li.push i+'$'
      dict_li.push i+':'+i+'$'

    js.push "`var #{var_li.join(',')};onMount(onI18n(o=>({#{dict_li.join(',')}}=o)))`"
    r[script_line] += js.join(';')

  # console.log(r.join('\n'))
  return r.join('\n')

sveltePreprocess.unshift(
  markup: ({content, filename})=>
    if filename.endsWith '.svelte'
      return {
        code: svelte(content)
      }
    return
)
