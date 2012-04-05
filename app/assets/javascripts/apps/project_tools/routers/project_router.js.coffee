class Project.Routers.ProjectRouter extends Backbone.Router
  initialize: (options) ->
    @actions = new Project.Collections.ActionsCollection()
    @actions.reset options.project.actions

  routes:
    ":id/actions"                     : "actions"
    ":actionId"                       : "childActions"
    ".*"                              : "actions"

  actions: (id) ->
    view = new Project.Views.Actions.IndexView(@actions.roots())
    $("#project").html(view.render().el)

  childActions: (actionId) ->
    view = new Project.Views.Actions.IndexView(@actions.byParentId(actionId))
    $(".brand").html(@actions.get(actionId).get("title"))
    $("#project").html(view.render().el)
