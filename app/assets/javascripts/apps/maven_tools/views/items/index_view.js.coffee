Actions.Views.Items ||= {}

class Actions.Views.Items.IndexView extends Backbone.View
  tagName: "section"
  id: "items"

  initialize: () ->
    _.bindAll(this, 'addOne', 'addAll', 'render')
    @collection=@options
    @options.items.bind('reset', @addAll)
    $(@el).sortable(
      revert: true
      update: _.bind(@save_order, @)
    )

  addAll: () ->
    @options.items.sortByPosition().each (item) =>
      @addOne(item)

  addOne: (item) ->
    view = new Actions.Views.Items.EditView({ model: item, template: @options.template})
    $(@el).append(view.render().el)

  save_order: (e, ui)->
    moved_item_id=ui.item.attr("data-id")
    new_prev_item=e.view.$(e.target.parentElement).prev().attr("data-id")
    @collection.items.saveSortOrder(moved_item_id, new_prev_item)


  render: ->
    $(@el).append('<header></header>')
    @addAll()

    return this