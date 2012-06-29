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
    selector = "div[data-id=item_id]"
    $(selector.replace(/item_id/, item.get("_id") )) if item?

  next: ()->
    get_item_view(@model.next())

  prev: ()->
    get_item_view(@model.prev())

  destroy: (e) ->
    backspase = e.which == 8
    if (@title().val() == '' && @description().html() == '') || (!backspase && confirm("Are you sure?"))
      @model.destroy()  if @model?
      $(@el).unbind()
      @focus_prev()
      @remove()
      return false

  enable_sorting: (e) ->
    container=$el.parent()
    $(container).sortable("enable")
    e.preventDefault()

  disable_sorting: (e) ->
    container=$el.parent()
    $(container).sortable( "disable" )
    e.preventDefault()