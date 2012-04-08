class ProjectApp.Routers.ProjectRouter extends Backbone.Router
  initialize: (options) ->
    @project = new ProjectApp.Models.Project(options.project)

  routes:
    "actions"                     : "actions"
    "actions/:actionId/actions"   : "childActions"
    ".*"                          : "actions"

  actions: (id) ->
    view = new ProjectApp.Views.Actions.IndexView(actions: @project.actions.roots())
    $("#action_header").html(@project.title)
    $("#action_header").attr("href", "#actions")
    $("#project").html(view.render().el)

  childActions: (actionId) ->
    action = @project.actions.get(actionId)
    view = new ProjectApp.Views.Actions.IndexView(actions: @project.actions.byParentId(actionId))
    $("#action_header").html(action.get("title"))
    if action.isRoot()
      $("#action_header").attr("href", "#actions")
    else
      $("#action_header").attr("href", "#actions/#{action.get("parent_id")}/actions")
    $("#project").html(view.render().el)
