class Actions.Routers.TemplatesRouter extends Backbone.Router
  initialize: (options) ->
    @templates = new Actions.Collections.TemplatesCollection()
    @templates.reset options.templates

  routes:
    "/index"     : "index"
    "/:id/items" : "items"
    ".*"         : "index"

  index: ->
    @view = new Actions.Views.Breadcrumbs.IndexView(model: null)
    $(".page-header").html(@view.render().el)
    @view = new Actions.Views.Templates.IndexView(templates: @templates)
    $("#templates").html(@view.render().el)
    @view = new Actions.Views.Templates.NewView(collection: @templates)
    $("#templates").prepend(@view.render().el)

  items: (id) ->
    template = @templates.get(id)
    @view = new Actions.Views.Breadcrumbs.IndexView(model: template)
    $(".page-header").html(@view.render().el)
    @view = new Actions.Views.Items.IndexView(items: template.items)
    $("#templates").html(@view.render().el)
    @view = new Actions.Views.Items.NewView(template: template)
    $("#templates #items").append(@view.render().el)