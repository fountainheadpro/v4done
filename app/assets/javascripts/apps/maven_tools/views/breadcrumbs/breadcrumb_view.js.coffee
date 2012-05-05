Actions.Views.Breadcrumbs ||= {}

class Actions.Views.Breadcrumbs.BreadcrumbView extends Backbone.View
  template: JST["apps/maven_tools/templates/breadcrumbs/breadcrumb"]
  tagName: 'li'

  render: ->
    title = @options.title.substring(0, 50)
    title = title + '…' if @options.title.length > 50
    $(this.el).html(@template({ title: title, tooltip: @options.title, link: @options.link, active: @options.active }))
    return this