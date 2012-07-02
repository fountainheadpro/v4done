class Actions.Routers.TemplatesRouter extends Backbone.Router
  initialize: (options) ->
    @templates = new Actions.Collections.TemplatesCollection()
    @templates.reset options.templates

  routes:
    "index"                        : "index"
    ":id/items"                    : "show"
    ":templateId/items/:id/items"  : "show"
    ".*"                           : "index"

  index: ->
    view = new Actions.Views.Breadcrumbs.IndexView(template: null, item: null)
    $(".page-header").html(view.render().el)

    view = new Actions.Views.Templates.IndexView(templates: @templates)
    $("section#templates").html(view.render().el)

    view = new Actions.Views.Templates.NewView(collection: @templates)
    $("section#templates").prepend(view.render().el)

    $("#deleted-templates").show()

  show: (templateId, itemId) ->
    template = @templates.get(templateId)

    if !template? || template.isDeleted()
      window.location.replace("/deleted_templates/#{templateId}")

    render= ->
      $("#deleted-templates").hide()
      view = new Actions.Views.Templates.EditController(model: template, itemId: itemId)
      view.render()

    if template.has('loaded_at') && template.get('loaded_at')?
      render()
    else
      template.items.fetch
        success: () ->
          template.set('loaded_at', new Date())
          render()
        error: () ->
          alert("Sorry, we can't load this template. Please try again later.")
          window.location.replace("/templates")
