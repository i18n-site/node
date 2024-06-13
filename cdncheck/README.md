[‼️]: ✏️README.mdt

# @3-/cdncheck

[test/main.coffee](./test/main.coffee) :

```coffee
#!/usr/bin/env coffee

> @3-/cdncheck

console.log await cdncheck(
  'i18n.site'
  '.i'
  [
    '110.53.110.41'
    '172.67.203.142'
  ]
)
```

output :

```
[
  [ '110.53.110.41', 150, 'JSP3/2.0.14' ],
  [ '172.67.203.142', 703, 'cloudflare' ]
]
```
