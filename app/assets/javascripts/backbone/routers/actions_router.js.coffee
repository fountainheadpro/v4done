class Actions.Routers.ActionsRouter extends Backbone.Router
  initialize: (options) ->
    @actions = new Actions.Collections.ActionsCollection()
    @actions.reset options.actions

  routes:
    "/new"      : "newAction"
    "/index"    : "index"
    "/:id/edit" : "edit"
    "/:id"      : "show"
    ".*"        : "index"

  newAction: ->
    @view = new Actions.Views.Actions.NewView(collection: @actions)
    $("#actions").html(@view.render().el)

  index: ->
    @view = new Actions.Views.Actions.IndexView(actions: @actions)
    $("#actions").html(@view.render().el)

  show: (id) ->
    action = @actions.get(id)
    @view = new Actions.Views.Actions.ShowView(model: action)
    $("#actions").html(@view.render().el)
    
  edit: (id) ->
    action = @actions.get(id)

    @view = new Actions.Views.Actions.EditView(model: action)
    $("#actions").html(@view.render().el)
  