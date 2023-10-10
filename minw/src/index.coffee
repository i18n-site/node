< (b)=>
  {clientWidth, clientHeight:height} = b
  w = clientWidth
  diff = 128
  while w > 12 # 避免最后一行标签太少
    if diff > clientWidth
      diff /= 2
      continue
    if height == b.clientHeight
      w -= diff
      b.style.width = w+'px'
    else
      if diff == 1
        ++w
        break
      else
        w += diff
        b.style.width = w+'px'
        diff /= 2
  return w
