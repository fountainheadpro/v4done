class ProjectApp.Routers.ProjectRouter extends Backbone.Router
  initialize: (options) ->
    @project = new ProjectApp.Models.Project(options.project)

  routes:
    "actions"                     : "actions"
    "actions/:actionId/actions"   : "childActions"
    ".*"                          : "actions"

  actions: (id) ->
    view = new ProjectApp.Views.Actions.IndexView(actions: @project.actions.roots())
    $("#project").html(view.render().el)

  childActions: (actionId) ->
    view = new ProjectApp.Views.Actions.IndexView(actions: @project.actions.byParentId(actionId))
    $(".brand").html(@project.actions.get(actionId).get("title"))
    $("#project").html(view.render().el)
