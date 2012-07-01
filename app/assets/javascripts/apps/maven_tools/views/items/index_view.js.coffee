Actions.Views.Items ||= {}

class Actions.Views.Items.IndexView extends Backbone.View
  tagName: "section"
  id: "items"
  view_name: 'index_view'


  initialize: () ->
    _.bindAll(this, 'addOne', 'addAll', 'render')
    @collection=@options
    @options.items.bind('reset', @addAll)
    $(@el).sortable(
      revert: true
      helper: "original"
      update: _.bind(@save_order, @)
    )
    $(@el).sortable("disable")

  addAll: () ->
    @children={}
    @container.item_ids=[]
    @options.items.each (item) =>
      @container.item_ids.push(item.id)
      @addOne(item)

  addOne: (item) ->
    view = new Actions.Views.Items.EditView({ model: item, template: @options.template})
    view.container=@container
    $(@el).append(view.render().el)
    @container.children[item.get("_id")]=view


  save_order: (e, ui)->
    moved_item_id=ui.item.data("id")
    new_prev_item=e.view.$(e.target.parentElement).prev().data("id")
    new_next_item=e.view.$(e.target.parentElement).next().data("id")
    @collection.items.saveSortOrder(moved_item_id, new_prev_item, new_next_item)


  render: ->
    $(@el).append('<header></header>')  #TODO: CHANGE THIS!!!
    @addAll()
    return this

  new_item: ->
    if !$(@el).next('.item').hasClass('new_item')
      parentItem = @options.template.items.get(@model.get('parent_id')) if @model.has('parent_id')
      view = new Actions.Views.Items.NewView(template: @options.template, parentItem: parentItem)
      $(@el).after(view.render().el)
      view.title().focus()
    else
      @focus_next()