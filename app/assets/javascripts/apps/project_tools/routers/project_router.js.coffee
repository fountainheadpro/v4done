class Project.Routers.ProjectRouter extends Backbone.Router
  initialize: (options) ->
    @actions = new Project.Collections.ActionsCollection()
    @actions.reset options.project.actions
    @project_title=options.project.title

  routes:
    ":id/actions"                     : "actions"
    ":action_id"                    : "child_actions"
    ".*"                              : "actions"

  actions: (id) ->
    view = new Project.Views.Actions.IndexView(@actions.roots())
    $("#action_header").html(@project_title)
    $("#project").html(view.render().el)

  child_actions: (action_id) ->
    view = new Project.Views.Actions.IndexView(@actions.byParentId(action_id))
    $("#action_header").html(@actions.get(action_id).get("title"))
    $("#action_header").attr("href","#{window.location.pathname}##{@actions.get(action_id).get("parent_id")||""}")
    $("#project").html(view.render().el)
