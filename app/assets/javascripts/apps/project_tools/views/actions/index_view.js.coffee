Project.Views.Actions ||= {}

class Project.Views.Actions.IndexView extends Backbone.View
  tagName: "div"
  id: "actions"

  initialize: () ->
    _.bindAll(this, 'addOne', 'addAll', 'render')
    @options.actions.bind('reset', @addAll)

  addAll: () ->
    @options.actions.each (action) =>
      @addOne(action)

  addOne: (action) ->
    view = new Project.Views.Actions.EditView({ model: action })
    $(@el).append(view.render().el)

  render: ->
    @addAll()

    return this