> marked > marked

# https://marked.js.org/using_pro
renderer = {
  link:(href, title, text)=>
    r = """<a href="#{href}" target=_blank"""
    if title
      r += " title=\"#{title}\""
    r+">#{text}</a>"
}

marked.use({ renderer })

export default marked.parse
