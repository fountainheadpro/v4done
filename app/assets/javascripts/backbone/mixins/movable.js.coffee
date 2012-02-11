Actions.Mixins.Movable ||= {}
Actions.Mixins.Movable =
  move: (e) ->
    if e.which in [38, 40]
      e.preventDefault()
      e.stopPropagation()
      @focus_next(e.target, e) if e.which == 40
      @focus_prev(e.target, e) if e.which == 38

  focus_next: (current_element) ->
    if current_element? && current_element.name == 'title'
      next_el = @$('textarea[name="description"]')
      next_el = $(@el).next().find('textarea[name="title"]:first') if next_el.length == 0
      next_el.focus()
    else
      $(@el).next().find('textarea[name="title"]:first').focus()

  focus_prev: (current_element) ->
    if current_element? && current_element.name == 'description'
      @$('textarea[name="title"]').focus()
    else
      prev_el = $(@el).prev().find('textarea:visible:last')
      prev_el = $(@el).parent().prev().find('textarea:visible:last') if prev_el.length == 0
      prev_el.focus()
