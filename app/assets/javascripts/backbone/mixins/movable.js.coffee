Actions.Mixins.Movable ||= {}
Actions.Mixins.Movable =
  move: (e) ->
    if e.keyCode == 40 || e.keyCode == 38
      e.preventDefault()
      e.stopPropagation()
      @focus_next() if e.keyCode == 40
      @focus_prev() if e.keyCode == 38

  focus_next: ->
    $(@el).next().find('textarea[name="title"]').focus()

  focus_prev: ->
    $(@el).prev().find('textarea[name="title"]').focus()