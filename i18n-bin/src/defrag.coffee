> html-entities > decode

NO_SPACE = new Set([
  'ja', 'km', 'lo', 'th', 'zh-TW', 'zh'
])

< (to, i, src)=>
  i = decode(i) #.replace(/>\s+\)/g,'>) ')

  if src.startsWith('#') and to.startsWith('*')
    to = '#'+src[1..]

  # 给<br 补上空格
  if not NO_SPACE.has to
    for [split,space_pos,offset] from [
      ['<br ',[-1], 0]
      ['>',[0,1],1]
    ]
      src_li = src.split(split)
      if src_li.length > 1
        ili = i.split(split)
        for j,pos in ili
          s = src_li[pos]
          if j.slice(...space_pos) != ' ' and s.slice(...space_pos)==' '
            if offset
              ili[pos]=' '+ili[pos]
            else
              ili[pos]+=' '
          i = ili.join(split)
  i
