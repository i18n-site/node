< (elem, dict)=>
  for event,func of dict
    elem.addEventListener(event, func)
  =>
    for event,func of dict
      elem.removeEventListener(event, func)
    return
