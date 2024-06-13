[‼️]: ✏️README.mdt

# @3-/ipreq

[test/main.coffee](./test/main.coffee) :

```coffee
#!/usr/bin/env coffee

> @3-/ipreq/fTxt.js

console.log '>>>',await fTxt(
  'i18n.site'
  '.i'
  '111.63.51.41'
  2000
)
```

output :

```
>>> [
  'i18n.site\n',
  {
    'accept-ranges': 'bytes',
    'alt-svc': 'h3="opencdnh3.jomodns.com:443"; ma=300, quic="111.63.51.42:443"; ma=300; v="44,43,39"',
    'cache-control': 'max-age=99999',
    connection: 'close',
    'content-length': '10',
    'content-type': 'application/octet-stream',
    date: 'Mon, 01 Jan 2024 09:17:03 GMT',
    etag: '"2f29c7b7d3c5c039eab5f95d1fe5fcee"',
    server: 'JSP3/2.0.14',
    'strict-transport-security': 'max-age=63072000; includeSubDomains',
    'x-cache-status': 'MISS'
  },
  200
]
```
