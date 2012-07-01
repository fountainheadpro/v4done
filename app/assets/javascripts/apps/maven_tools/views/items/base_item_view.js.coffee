Actions.Views.Items ||= {}

class Actions.Views.Items.BaseItemView extends Backbone.View

  title: Actions.Mixins.CommonElements.title
  description: Actions.Mixins.CommonElements.description
  focus_next: Actions.Mixins.Navigatable.focus_next
  focus_prev: Actions.Mixins.Navigatable.focus_prev

  constructor: (options) ->
    super(options)
    @model=options.model

  get_item_view=(item)->
    @container.children[item.id]

  next: ()->
    id=@$el.data('id')
    id=id.slice(0,str.length-1) if id.endsWith('_')
    if @model.next()
      get_item_view(@model.next())


  prev: ()->
    get_item_view(@model.prev())


  enable_sorting: (e) ->
    container=$el.parent()
    $(container).sortable("enable")
    e.preventDefault()

  disable_sorting: (e) ->
    container=$el.parent()
    $(container).sortable( "disable" )
    e.preventDefault()