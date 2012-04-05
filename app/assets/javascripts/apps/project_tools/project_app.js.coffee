#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

window.ProjectApp =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}
  Mixins: {}
  init: (project) ->
    ProjectApp.router = new ProjectApp.Routers.ProjectRouter({ project: project })
    Backbone.history.start()

