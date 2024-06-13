< (title)=>
  pos = title.indexOf ':'
  if pos > 0
    tip = title.slice(pos + 2).trim()
    title = title.slice(0, pos).trim()
  [
    title
    tip
  ]
