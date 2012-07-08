#= require_self
#= require_tree ./templates
#= require_tree ./mixins
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

window.Sparks =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}
  Mixins: {}
  init_templates: (templates) ->
    Sparks.router = new Sparks.Routers.SparksRouter({ templates: templates })
    Backbone.history.start()