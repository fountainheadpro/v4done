Actions.Views.Items ||= {}

class Actions.Views.Items.IndexView extends Backbone.View
  tagName: "div"
  id: "items"
  className: "row"

  initialize: () ->
    _.bindAll(this, 'addOne', 'addAll', 'render')

    @options.items.bind('reset', @addAll)
    @options.items.bind('add',   @addOne)

  addAll: () ->
    @options.items.each(@addOne)

  addOne: (item) ->
    view = new Actions.Views.Items.ItemView({ model: item })
    $(@el).prepend(view.render().el)

  render: ->
    @addAll()

    return this