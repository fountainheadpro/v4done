#= require_self
#= require_tree ./templates
#= require_tree ./mixins
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

window.Project =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}
  Mixins: {}
  init: (project) ->
    #window.addEventListener("load", ( -> setTimeout ( -> window.scrollTo(0,1))), false)
    Project.router = new Project.Routers.ProjectRouter({ project: project })
    Backbone.history.start()

