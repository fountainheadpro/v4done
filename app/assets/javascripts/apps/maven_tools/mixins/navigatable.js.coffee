Actions.Mixins.Navigatable ||= {}
Actions.Mixins.Navigatable =

  move: (e) ->
      if e.which in [38, 40]
        e.preventDefault()
        e.stopPropagation()
        @focus_next if e.which == 40
        @focus_prev if e.which == 38

  focus_prev: ->
    if @description().is(":focus")
      @title().focus()
    if @title().is(":focus")
      if @view_name=='new_item'
        @container.children.items_index.last_child().title().focus()
        return

      if @className=='template'
        return

      if @model.prev()?
        @container.children[@model.prev().id].title().focus()
      else
        @container.container.children.template_header.title().focus()

  focus_next: ->
    if @className=='template' #if we are in template header
      @parent_header.title().focus() if @parent_header? #going to parent header if it's there
      @container.children.items_index.first_child().title().focus() #going to the first header if it's there
      return

    if @model.next()? #we are navigating items
      @container.children[@model.next().id].title().focus()
    else
      @container.container.children.new_item.title().focus()