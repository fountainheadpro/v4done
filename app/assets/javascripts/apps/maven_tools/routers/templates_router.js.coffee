class Actions.Routers.TemplatesRouter extends Backbone.Router
  initialize: (options) ->
    @templates = new Actions.Collections.TemplatesCollection()
    @templates.reset options.templates

  routes:
    "index"                        : "index"
    ":id/items"                    : "items"
    ":templateId/items/:id/items"  : "subitems"
    ".*"                           : "index"

  index: ->
    view = new Actions.Views.Breadcrumbs.IndexView(template: null, item: null)
    $(".page-header").html(view.render().el)

    view = new Actions.Views.Templates.IndexView(templates: @templates)
    $("section#templates").html(view.render().el)

    view = new Actions.Views.Templates.NewView(collection: @templates)
    $("section#templates").prepend(view.render().el)

  items: (id) ->
    template = @templates.get(id)

    view = new Actions.Views.Items.IndexView(template: template, items: template.items.byParentId(null))
    $("section#templates").html(view.render().el)

    view = new Actions.Views.Templates.EditView(model: template)
    $("section#templates").prepend(view.render().el)

    view = new Actions.Views.Items.NewView(template: template)
    $("section#templates #items").append(view.render().el)

    $("div.new_item:last textarea[name='title']").focus()


  subitems: (templateId, id) ->
    template = @templates.get(templateId)
    item = template.items.get(id)

    view = new Actions.Views.Templates.EditView(model: template)
    $("section#templates").html(view.render().el)

    view = new Actions.Views.Items.IndexView(template: template, items: template.items.byParentId(item.get('_id')))
    $("section#templates").append(view.render().el)

    view = new Actions.Views.Breadcrumbs.IndexView(template: template, item: item)
    $("section#items header").append(view.render().el)

    view = new Actions.Views.Items.EditDetailsView({ model: item, template: template })
    $("section#items header").append(view.render().el)

    view = new Actions.Views.Items.NewView(template: template, parentItem: item)
    $("section#items").append(view.render().el)

    $("div.new_item:last textarea[name='title']").focus()
