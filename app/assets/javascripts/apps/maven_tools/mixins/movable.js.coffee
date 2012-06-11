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
      #nextEl = @$('textarea[name="description"]')
      #nextEl = $(@el).next().find('textarea[name="title"]:first') if nextEl.length == 0
      nextEl = $(@el).next().find('textarea[name="title"]:first').focus()
      nextEl = $(@el).parent().next().find('textarea[name="title"]:first') if nextEl.length == 0
      nextEl.focus()
    else
      nextEl = $(@el).next().find('textarea[name="title"]:first').focus()
      nextEl = $(@el).parent().next().find('textarea[name="title"]:first') if nextEl.length == 0
      nextEl.focus()

  focus_prev: (current_element) ->
    if current_element? && current_element.name == 'description'
      @$('textarea[name="title"]').focus()
    else
      prevEl = $(@el).prev().find('textarea[name="title"]:last')
      #prevEl = $(@el).parent().prev().find('textarea[name="title"]:last') if prevEl.length == 0
      prevEl = $(@el).parent().parent().find('textarea[name="title"]:first') if prevEl.length == 0
      prevEl.focus()
