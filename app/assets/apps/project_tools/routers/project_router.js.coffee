class Project.Routers.ProjectRouter extends Backbone.Router
  initialize: (options) ->
    @project = new Project.Collections.Project()
    @project.reset options.project

  routes:
    ":id/actions"                     : "actions"
    ":project_id/actions/:id/actions" : "child_actions"

  actions: (id) ->

    view = new Actions.Views.Breadcrumbs.IndexView(template: template, item: null)
    $(".page-header").html(view.render().el)

    view = new Actions.Views.Items.IndexView(template: template, items: template.items.byParentId(null))
    $("#templates").html(view.render().el)

    view = new Actions.Views.Templates.EditView(model: template)
    $("#templates").prepend(view.render().el)

    view = new Actions.Views.Items.NewView(template: template)
    $("#templates #items").append(view.render().el)

    $(".new_item:last textarea[name='title']").focus()


  child_actions: (project_id, id) ->
    template = @templates.get(template_id)
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
