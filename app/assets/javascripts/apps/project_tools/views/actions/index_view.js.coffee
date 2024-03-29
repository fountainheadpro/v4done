ProjectApp.Views.Actions ||= {}

class ProjectApp.Views.Actions.IndexView extends Backbone.View
  tagName: "div"
  id: "actions"

  initialize: () ->
    _.bindAll(this, 'addOne', 'addAll', 'render')
    @options.actions.bind('reset', @addAll)

  addAll: () ->
    @options.actions.sortByPosition().each (action) =>
      @addOne(action)

  addOne: (action) ->
    view = new ProjectApp.Views.Actions.EditView({ model: action })
    $(@el).append(view.render().el)

  render: ->
    @addAll()

    return this