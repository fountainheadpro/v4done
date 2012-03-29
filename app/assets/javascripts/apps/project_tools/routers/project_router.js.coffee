class Project.Routers.ProjectRouter extends Backbone.Router
  initialize: (options) ->
    @actions = new Project.Collections.ActionsCollection()
    @actions.reset options.project.actions

  routes:
    ":id/actions"                     : "actions"
    ":action_id"                    : "child_actions"
    ".*"                              : "actions"

  actions: (id) ->
    view = new Project.Views.Actions.IndexView(@actions.roots())
    $("#project").html(view.render().el)

  child_actions: (action_id) ->
    view = new Project.Views.Actions.IndexView(@actions.byParentId(action_id))
    $(".brand").html(@actions.get(action_id).get("title"))
    $("#project").html(view.render().el)
