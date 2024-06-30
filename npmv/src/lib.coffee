_f = (url)=>
  r = await fetch('https://'+url)
  if r.status != 200
    throw r
  return r

fjson = (url)=>
  (await _f(url)).json()

fbin = (url)=>
  new Uint8Array await (await _f(url)).arrayBuffer()

< ver = (pkg)=>
  {version} = await fjson "registry.npmjs.org/#{pkg}/latest"
  return version

< (pkg, ver, path) =>
  prefix = "www.npmjs.com/package/#{pkg}/"
  {files} = await fjson prefix+"v/#{ver}/index"
  v = files['/'+path]
  if not v
    return ''
  fbin prefix + "file/"+v.hex
