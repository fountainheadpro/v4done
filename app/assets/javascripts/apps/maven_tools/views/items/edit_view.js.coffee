Actions.Views.Items ||= {}

class Actions.Views.Items.EditView extends Actions.Views.Items.BaseItemView
  template: JST["apps/maven_tools/templates/items/edit"]
  className: 'item edit_item'
  view_name: 'edit_item'

  goToParentItem: Actions.Mixins.GoTo['parentItem']
  goToItemDetails: Actions.Mixins.GoTo['itemDetails']

  events:
    "click i.destroy" : "destroy"
    "mousedown i.mover" : "enable_sorting"
    "mouseup i.mover" : "disable_sorting"
    "keydown .editable": "keymap"
    "blur .editable"   : "update"
    "focusin .editable": "highlight"

  keymap: (e) ->
    if e.shiftKey
      @update(e) if e.which in [13, 38, 40]
      switch e.which
        when 38 then @container.$el.trigger("parent_item",@) #@goToParentItem(@options.template, @options.template.items.get(@model.get('parent_id')))
        when 13,40 then @container.$el.trigger("item_details") #@goToItemDetails(@options.template, @model)
        when 9 then @update(e)
    else if e.target.name == 'title'
      switch e.which
        when 38 then @container.$el.trigger({type: "prev_item", id: @$el.data('id')})
        when 40 then @container.$el.trigger({type: "next_item", id: @$el.data('id')})
        when 8 then @destroy(e)
        when 13 then @update(e)
        when 9 then @update(e)
    else if e.target.name == 'description'
      switch e.which
        when 38 then @move(e) if Actions.Mixins.CarerPosition.atFirstLine(e.target)
        when 40 then @move(e) if Actions.Mixins.CarerPosition.atLastLine(e.target)

  destroy: (e) ->
    backspase = e.which == 8
    if (@title().val() == '' && @description().html() == '') || (!backspase && confirm("Are you sure?"))
      e.preventDefault()
      e.stopPropagation()
      @$el.unbind()
      @container.$el.trigger({type: "destroy", id: @$el.data('id')})

  update: (e) ->
    e.preventDefault()
    e.stopPropagation()
    title = @title().val()
    description = @description().html()
    previous_item = @model.prev()
    if @model.get('title') != title || @model.get('description') != description
      @model.save({ title: title, description: description},
        success: (item) => @model = item
      )
    if e.which == 13 && !e.shiftKey
      @container.$el.trigger({type: "new_item", id: @$el.data('id')} )


  highlight: (e)->
    $('.selected div[name="description"]').each (i, item)->
      $(item).parent().hide() if $(item).html() == ''
    $('.selected').removeAttr('style')
    $('.selected').removeClass('selected')
    @$el.addClass('selected')
    if @title().is(':focus')
      @title().attr('tabindex', 0)
      @description().attr('tabindex', 0)
    if @description().is(':focus')
      @title().removeAttr('tabindex')
      @description().attr('tabindex', 0)
      @next().find('[name=title]').attr('tabindex', 0)
    @$('.description').show()

  enable_sorting: (e) ->
    container = @$el.parent()
    $(container).sortable("enable")
    e.preventDefault()

  disable_sorting: (e) ->
    container=@$el.parent()
    $(container).sortable( "disable" )
    e.preventDefault()

  attributes: ->
    { 'data-id': @model.id }

  render: ->
    $(@el).data('id', @model.get('_id'))
    $(@el).html(@template({ title: @model.get('title'), description: @model.get('description'), _id: @model.get('_id'), template_id: @options.template.get('_id')}))
    @description().action_editor()
    return this