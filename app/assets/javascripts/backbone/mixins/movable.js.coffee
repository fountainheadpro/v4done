Actions.Mixins.Movable ||= {}
Actions.Mixins.Movable =
  move: (e) ->
    if e.keyCode == 40 || e.keyCode == 38
      e.preventDefault()
      e.stopPropagation()
      textarea = $(@el).next().find('textarea[name="title"]') if e.keyCode == 40
      textarea = $(@el).prev().find('textarea[name="title"]') if e.keyCode == 38
      textarea.focus()