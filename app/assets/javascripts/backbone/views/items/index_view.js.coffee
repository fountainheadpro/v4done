Actions.Views.Items ||= {}

class Actions.Views.Items.IndexView extends Backbone.View
  tagName: "div"
  id: "items"
  className: "row"

  initialize: () ->
    _.bindAll(this, 'addOne', 'addAll', 'render')

    @options.items.bind('reset', @addAll)

  addAll: () ->
    @options.items.each(@addOne)

  addOne: (item) ->
    view = new Actions.Views.Items.EditView({ model: item, template: @options.template, subitemsCount: @options.template.items.byParentId(item.get('_id')).length })
    $(@el).append(view.render().el)

  render: ->
    @addAll()

    return this