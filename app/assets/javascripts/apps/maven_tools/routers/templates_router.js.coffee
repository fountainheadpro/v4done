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

  show: (templateId, itemId) ->
    template = @templates.get(templateId)

    if !tempalte? || template.isDeleted()
      window.location.replace("/deleted_templates/#{templateId}")

    view = new Actions.Views.Templates.EditView(model: template)
    $("section#templates").html(view.render().el)

    if itemId?
      item = template.items.get(itemId)

      view = new Actions.Views.Items.IndexView(template: template, items: template.items.byParentId(item.get('_id')))
      $("section#templates").append(view.render().el)

      view = new Actions.Views.Breadcrumbs.IndexView(template: template, item: item)
      $("section#items header").append(view.render().el)

      view = new Actions.Views.Items.EditDetailsView({ model: item, template: template })
      $("section#items header").append(view.render().el)
    else
      view = new Actions.Views.Items.IndexView(template: template, items: template.items.roots())
      $("section#templates").append(view.render().el)

    view = new Actions.Views.Items.NewView(template: template, parentItem: item)
    $("section#items").append(view.render().el)

    $("div.new_item:last textarea[name='title']").focus()
