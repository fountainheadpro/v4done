class Project.Routers.ProjectRouter extends Backbone.Router
  initialize: (options) ->
    @actions = new Project.Collections.ActionsCollection()
    @actions.reset options.project.actions
    @project_name = options.project.title

  routes:
    ":id/actions"                     : "actions"
    ":action_id"                      : "child_actions"
    ".*"                              : "actions"

  actions: (id) ->
    $("a.brand").html(@project_name)
    $("a.brand").attr("href","#")
    view = new Project.Views.Actions.IndexView(@actions.roots())
    $("#project").html(view.render().el)

  child_actions: (action_id) ->
    parent_id=@actions.get(action_id).get("parent_id")||""
    $("a.brand").html(@actions.get(action_id).get("title"))
    $("a.brand").attr("href","#{window.location.pathname}##{parent_id}")
    view = new Project.Views.Actions.IndexView(@actions.byParentId(action_id))
    $("#project").html(view.render().el)
