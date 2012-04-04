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
    #view = new Actions.Views.Breadcrumbs.IndexView(template: null, item: null)
    $(".page-header").html("")

    view = new Actions.Views.Templates.IndexView(templates: @templates)
    $("#templates").html(view.render().el)

    view = new Actions.Views.Templates.NewView(collection: @templates)
    $("#templates").prepend(view.render().el)

  items: (id) ->
    template = @templates.get(id)

    #view = new Actions.Views.Breadcrumbs.IndexView(template: template, item: null)
    $(".page-header").html("")

    view = new Actions.Views.Items.IndexView(template: template, items: template.items.byParentId(null))
    $("#templates").html(view.render().el)

    view = new Actions.Views.Templates.EditView(model: template)
    $("#templates").prepend(view.render().el)

    view = new Actions.Views.Items.NewView(template: template)
    $("#templates #items").append(view.render().el)

    $(".new_item:last textarea[name='title']").focus()


  subitems: (templateId, id) ->
    template = @templates.get(templateId)
    item = template.items.get(id)

    view = new Actions.Views.Breadcrumbs.IndexView(template: template, item: item)
    $(".page-header").html(view.render().el)

    view = new Actions.Views.Items.IndexView(template: template, items: template.items.byParentId(item.get('_id')))
    $("#templates").html(view.render().el)

    view = new Actions.Views.Items.EditDetailsView({ model: item, template: template })
    $("#templates").prepend(view.render().el)

    view = new Actions.Views.Items.NewView(template: template, parentItem: item)
    $("#templates #items").append(view.render().el)

    $(".new_item:last textarea[name='title']").focus()
