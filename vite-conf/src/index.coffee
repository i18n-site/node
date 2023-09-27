> ./svelte.js:
  @w5/vite-conf
  path > join

< (dir)=>
  conf = (await ViteConf(dir))()
  # for p from [
  #   '@8p/i18n'
  # ]
  #   conf.resolve.alias[p] = join(
  #     dir,'node_modules',p
  #   )
  # console.log conf.resolve
  conf
