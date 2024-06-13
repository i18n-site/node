[‼️]: ✏️README.mdt

# @3-/cname_flatten

[test/main.coffee](./test/main.coffee) :

```coffee
#!/usr/bin/env coffee

> @3-/cname_flatten:flatten

process.on(
  'uncaughtException'
  (err) =>
    console.error('uncaughtException',err)
    return
)

for i from await flatten(
  'AAAA'
  # 'A'
  'i18n.site'
  'i18n.site.a.bdydns.com'
  'user0.cf'
)
  console.log '>',i
```

output :

```
./out.txt
```
