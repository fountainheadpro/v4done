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
    if @actions.get(actionId).get("parent_id")
      $(".brand").html(@project.actions.get(actionId).get("title"))
      $(".brand").attr("href","#actions/#{@actions.get(actionId).get("parent_id")}/actions")
    else
      $(".brand").html(@project.title)
      $(".brand").attr("href","#actions")
    $("#project").html(view.render().el)
