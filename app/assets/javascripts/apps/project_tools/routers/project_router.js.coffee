class Project.Routers.ProjectRouter extends Backbone.Router
  initialize: (options) ->
    @actions = new Project.Collections.ActionsCollection()
    @actions.reset options.project.actions
    @project_title=options.project.get('title')

  routes:
    ":id/actions"                     : "actions"
    ":action_id"                    : "child_actions"
    ".*"                              : "actions"

  actions: (id) ->
    view = new Project.Views.Actions.IndexView(@actions.roots())
    $("#project").html(view.render().el)

  child_actions: (action_id) ->
    view = new Project.Views.Actions.IndexView(@actions.byParentId(action_id))
    if @actions.get(action_id).get("parent_id")
      $(".brand").html(@actions.get(action_id).get("title"))
    else
      $(".brand").html(@project_title)
    $(".brand").attr("href","#{window.location.pathname}##{@actions.get(action_id).get("parent_id")||""}")
    $("#project").html(view.render().el)
