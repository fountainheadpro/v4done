Actions.Views.Items ||= {}

class Actions.Views.Items.EditView extends Backbone.View
  template: JST["apps/maven_tools/templates/items/edit"]
  className: 'item edit_item'

  move: Actions.Mixins.Movable['move']
  focus_next: Actions.Mixins.Movable['focus_next']
  focus_prev: Actions.Mixins.Movable['focus_prev']
  goToParentItem: Actions.Mixins.GoTo['parentItem']
  goToItemDetails: Actions.Mixins.GoTo['itemDetails']

  events:
    "click i.destroy" : "destroy"
    "mousedown i.mover" : "enable_sorting"
    "mouseup i.mover" : "disable_sorting"
    "keydown textarea": "keymap"
    "blur textarea"   : "update"
    "blur div[name=description]"   : "update"
    "focusin textarea": "highlight"
    "click div[name=description]"   : "focus_div"
    #"focusin div": "highlight"

  keymap: (e) ->
    if e.shiftKey
      @update(e) if e.which in [13, 38, 40]
      switch e.which
        when 38 then @goToParentItem(@options.template, @options.template.items.get(@model.get('parent_id')))
        when 13,40 then @goToItemDetails(@options.template, @model)
    else if e.target.name == 'title'
      switch e.which
        when 38, 40 then @move(e)
        when 8 then @destroy(e)
        when 13 then @update(e)
    else if e.target.name == 'description'
      switch e.which
        when 38 then @move(e) if Actions.Mixins.CarerPosition.atFirstLine(e.target)
        when 40 then @move(e) if Actions.Mixins.CarerPosition.atLastLine(e.target)

  update: (e) ->
    e.preventDefault()
    e.stopPropagation()
    title = @$("textarea[name='title']").val()
    description = @$("div[name='description']").html()
    previousId = $(@el).prevAll('.item.edit_item:first').data('id')
    if @model.get('title') != title || @model.get('description') != description || @model.get('previous_id') != previousId
      @model.save({ title: title, description: description, previous_id: previousId},
        success: (item) => @model = item
      )
    if e.which == 13 && !e.shiftKey
      if !$(@el).next('.item').hasClass('new_item')
        parentItem = @options.template.items.get(@model.get('parent_id')) if @model.has('parent_id')
        view = new Actions.Views.Items.NewView(template: @options.template, parentItem: parentItem)
        $(@el).after(view.render().el)
      @focus_next()

  destroy: (e) ->
    backspase = e.which == 8
    if (@$('textarea[name="title"]').val() == '' && @$('div[name="description"]').html() == '') || (!backspase && confirm("Are you sure?"))
      @model.destroy()
      $(@el).unbind()
      @focus_prev()
      @remove()
      return false

  highlight: (e)->
    $('.selected div[name="description"]').each (i, item)->
      $(item).parent().hide() if $(item).html() == ''
    $('.selected').removeAttr('style')
    $('.selected').removeClass('selected')
    $(@el).addClass('selected')
    $(e.target).show()
    @$('.description').show()

  enable_sorting: (e) ->
    container=$(e.target).parent().parent()
    $(container).sortable("enable")
    #  revert: true
    #  helper: "original"
    #  update: _.bind(@save_order, @)
    #)
    e.preventDefault()

  disable_sorting: (e) ->
    container=$(e.target).parent().parent()
    $(container).sortable( "disable" )
    e.preventDefault()

  save_order: (e,ui)->
    #fuck off

  focus_div: (e)->
    #$(e.target).focus()

  attributes: ->
    { 'data-id': @model.id }

  render: ->
    $(@el).data('id', @model.get('_id'))
    $(@el).html(@template({ title: @model.get('title'), description: @model.get('description'), _id: @model.get('_id'), template_id: @options.template.get('_id')}))
    $(@el).find('div[contenteditable=true]').action_editor()
    return this