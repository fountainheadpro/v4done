#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

window.Actions =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}
  Mixins: {}
  init_templates: (templates) ->
    new Actions.Routers.TemplatesRouter({ templates: templates })
    Backbone.history.start()