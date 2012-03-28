class Project.Routers.ProjectRouter extends Backbone.Router
  initialize: (options) ->
    @actions = new Project.Collections.ActionsCollection()
    @actions.reset options.project.actions

  routes:
    ":id/actions"                     : "actions"
    ":project_id/actions/:id/actions" : "child_actions"
    ".*"                              : "actions"

  actions: (id) ->
    view = new Project.Views.Actions.IndexView(@actions.roots())
    $("#project").html(view.render().el)

  child_actions: (project_id, id) ->
    view = new Project.Views.Actions.IndexView(project)
    $("#project").html(view.render().el)
