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
    if @actions.get(action_id).isLeaf
      $(".brand").attr("href","#{window.location.pathname}##{@actions.get(action_id).get("parent_id")||""}")
    else
      $(".brand").attr("href","#{window.location.pathname}")
    $("#project").html(view.render().el)
