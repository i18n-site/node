[‼️]: ✏️README.mdt

# @8n/tran_md

[test/main.coffee](./test/main.coffee) :

```coffee
#!/usr/bin/env coffee

> ../lib/index.js:tranMd
  @w5/uridir
  @w5/read
  @w5/write
  path > join

ROOT = uridir(import.meta)
enfp = join(ROOT,'en.md')
md = await tranMd(
  read join ROOT, 'zh.md'
  'zh'
)(
  'en'
  join ROOT, 'cache.zh.en'
  enfp
)
# console.log md
# write(
#   enfp
#   md
# )
```

output :

```
./out.txt
```
