> ./svelte.js:
  @w5/vite-conf
  path > join

< (dir)=>
  conf = (await ViteConf(dir))()
  conf.resolve.alias['@8n/fbin-md'] = join(
    dir
    'node_modules/@8n/fbin-md'
  )
  console.log conf
  conf
