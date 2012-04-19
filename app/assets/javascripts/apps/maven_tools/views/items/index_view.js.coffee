Actions.Views.Items ||= {}

class Actions.Views.Items.IndexView extends Backbone.View
  tagName: "section"
  id: "items"

  initialize: () ->
    _.bindAll(this, 'addOne', 'addAll', 'render')
    @options.items.bind('reset', @addAll)

  addAll: () ->
    @options.items.sortByPosition().each (item) =>
      @addOne(item)

  addOne: (item) ->
    view = new Actions.Views.Items.EditView({ model: item, template: @options.template})
    $(@el).append(view.render().el)

  render: ->
    $(@el).append('<header></header')
    @addAll()

    return this