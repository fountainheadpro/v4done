Project.Views.Actions ||= {}

class Project.Views.Actions.IndexView extends Backbone.View
  tagName: "div"
  id: "actions"

  initialize: () ->
    _.bindAll(this, 'addOne', 'addAll', 'render')
    @options.bind('reset', @addAll)

  addAll: () ->
    @options.each (action) =>
      @addOne(action)


  addOne: (action) ->
    view = new Project.Views.Actions.EditView({ model: action, project: @options})
    $(@el).append(view.render().el)

  render: ->
    @addAll()

    return this