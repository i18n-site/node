[‼️]: ✏️README.mdt

# @3-/apint

[test/main.coffee](./test/main.coffee) :

```coffee
#!/usr/bin/env coffee

> @3-/apint > gen_nt
  @3-/read
  @3-/uridir
  path > join

ROOT = uridir(import.meta)

rs = read join ROOT,'test.rs'

nt = gen_nt(rs,'')
console.log nt
```

output :

```
./out.txt
```
