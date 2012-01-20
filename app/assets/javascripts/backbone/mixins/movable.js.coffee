Actions.Mixins.Movable ||= {}
Actions.Mixins.Movable =
  move: (e) ->
    if e.keyCode == 40 || e.keyCode == 38
      e.preventDefault()
      e.stopPropagation()
      @focus_next(e.target) if e.keyCode == 40
      @focus_prev(e.target) if e.keyCode == 38

  focus_next: (current_element) ->
    if current_element? && current_element.name == 'title'
      @$('textarea[name="description"]').focus()
    else
      $(@el).next().find('textarea[name="title"]').focus()

  focus_prev: (current_element) ->
    if current_element? && current_element.name == 'description'
      @$('textarea[name="title"]').focus()
    else
      $(@el).prev().find('textarea:visible:last').focus()
