#= require_self
#= require_tree ./templates
#= require_tree ./mixins
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

window.Actions =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}
  Mixins: {}
  init_templates: (actions) ->
    Actions.router = new Actions.Routers.TemplatesRouter({ actions: actions })
    Backbone.history.start()