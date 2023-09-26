> @w5/vite-conf/sveltePreprocess.js

IMPORT_onMount = 1
IMPORT_onI18n = 2

IMPORT = {}

IMPORT[IMPORT_onMount] = 'import {onMount} from \'svelte\''
IMPORT[IMPORT_onI18n] = 'import onI18n from \'@8p/i18n/_.js\''


svelte = (txt)=>
  r = []
  in_script = false

  for line, pos in txt.split '\n'
    if line.startsWith '<script'
      in_script = pos
      auto_import = new Set
    else
      if in_script != false
        if line == '</script>'
          import_li = []
          for i from auto_import
            import_li.push IMPORT[i]
          if import_li.length
            r[in_script] = r[in_script]+import_li.join(';')
          in_script = false
        else
          if line.startsWith 'onMount '
            auto_import.add IMPORT_onMount
          if line.startsWith 'onI18n '
            for j from [IMPORT_onI18n, IMPORT_onMount]
              auto_import.add j
            line = 'onMount '+line
    r.push line
  return r.join('\n')

sveltePreprocess.unshift(
  markup: ({content, filename})=>
    if filename.endsWith '.svelte'
      return {
        code: svelte(content)
      }
    return
)

> @w5/vite-conf
  @w5/read


< (dir)=>
  (await ViteConf(dir))()
