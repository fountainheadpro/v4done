class Actions.Routers.TemplatesRouter extends Backbone.Router
  initialize: (options) ->
    @templates = new Actions.Collections.TemplatesCollection()
    @templates.reset options.templates

  routes:
    "/index"    : "index"
    ".*"        : "index"

  index: ->
    @view = new Actions.Views.Templates.IndexView(templates: @templates)
    $("#templates").html(@view.render().el)