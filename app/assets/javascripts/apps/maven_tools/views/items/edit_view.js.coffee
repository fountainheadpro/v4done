Actions.Views.Items ||= {}

class Actions.Views.Items.EditView extends Actions.Views.Items.BaseItemView
  template: JST["apps/maven_tools/templates/items/edit"]
  className: 'item edit_item'
  view_name: 'edit_item'


  child_events:
    "click i.destroy" : "destroy"
    "mousedown i.mover" : "enable_sorting"
    "mouseup i.mover" : "disable_sorting"
    "details [name=description]" : "details"

  events: _.extend(_.clone(Actions.Views.Items.BaseItemView::base_events), EditView::child_events)


  destroy: (e) ->
    backspase = e.which == 8
    if (@title().val() == '' && @description().html() == '') || (!backspase && confirm("Are you sure?"))
      e.preventDefault()
      e.stopPropagation()
      @$el.unbind()
      @container.$el.trigger({type: "destroy", id: @$el.data('id')})


  fold: (e)->
    super(e)
    @$('i.destroy').hide()

  details: ()->
    @container.$el.trigger("child_items",@)

  enable_sorting: (e) ->
    container = @$el.parent()
    $(container).sortable("enable")
    e.preventDefault()

  disable_sorting: (e) ->
    container=@$el.parent()
    $(container).sortable( "disable" )
    e.preventDefault()

  highlight: (e)->
    super(e)
    @$('i.destroy').show()

  save: (e)->
    super(e)
    if e.which == 13
      @container.$el.trigger({type: "new_item", id: @model.id})

  keymap: (e)->
    if e.shiftKey && e.which == 13
      @expand_description(e)
    else
      super(e)

  attributes: ->
    { 'data-id': @model.id }

  render: ->
    $(@el).data('id', @model.get('_id'))
    $(@el).html(@template({_id: @model.get('_id'), template_id: @options.template.get('_id')}))
    @title().val(@model.get('title'))
    @description().html(@model.get('description'))
    @description().action_editor()
    return this