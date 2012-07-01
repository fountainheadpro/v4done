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
      focus_item=@

    if @title().is(":focus")
      if @view_name=='template_header'
        return

      if @view_name=='parent_header'
        focus_item = @container.children.template_header

      if @view_name=='new_item'
        focus_item=@container.children.items_index.last_child()
        focus_item ||= @container.children.parent_header
        focus_item ||= @container.children.template_header

      if @view_name=='edit_item'
        if @model.prev()?
          focus_item=@container.children[@model.prev().id]
        else
          focus_item = @container.children.parent_header
          focus_item ||= @container.children.template_header

    focus_item.title().focus()

  focus_next: ->

    if @title().is(":focus")
      if @view_name=='template_header' #if we are in template header
        focus_item = @container.children.parent_header #going to parent header if it's there
        focus_item ||=@container.children.items_index.first_child()
        focus_item.title().focus() #going to the first header if it's there

      if @view_name=='parent_header'
        focus_item = @container.children.items_index.first_child()
        focus_item ||=@container.children.new_item

      if @view_name=='edit_item'
        if @model.next()? #we are navigating items
          @container.children[@model.next().id].title().focus()
        else
          @container.children.new_item.title().focus()

      if @view_name=='new_item'
        return

      focus_item.title().focus()