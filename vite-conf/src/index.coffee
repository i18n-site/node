> @w5/vite-conf

< (dir)=>
  conf = (await ViteConf(dir))()
  conf.plugins.push({
    name:'i18n-site',
    transform: (src, id)=>
      if id.endsWith '.svelte'
        console.log({src, id})
      return
  })
  conf
