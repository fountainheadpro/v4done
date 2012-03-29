Actions.Views.Breadcrumbs ||= {}

class Actions.Views.Breadcrumbs.BreadcrumbView extends Backbone.View
  template: JST["apps/maven_tools/templates/breadcrumbs/breadcrumb"]
  tagName: 'li'

  render: ->
    $(this.el).html(@template({ title: @options.title, link: @options.link, active: @options.active }))
    return this