ProjectApp.Views.Actions ||= {}

class ProjectApp.Views.Actions.EditView extends Backbone.View
  template: JST["apps/project_tools/templates/actions/edit"]
  className: "action row-fluid"

  events:
    "touch"       : "showSubactions"
    "click"       : "showSubactions"
    "click input.incomplete" : "saveStatus"

  initialize: () ->
    @model.bind('change', @render, @)

  showSubactions: (e) ->
    unless (@model.isLeaf())
      ProjectApp.router.navigate("actions/#{@model.get('_id')}/actions", { trigger: true })
    return false

  saveStatus: (e) ->
    e.preventDefault()
    e.stopPropagation()
    @model.toggle()

  attributes: ->
    { 'data-id': @model.id }

  render: ->
    $(@el).data('id', @model.get('_id'))
    $(@el).html(@template({ title: @model.get('title'), description: @model.get('description'), id: @model.get('_id'), child_count: @model.get('child_count'), leaf: @model.isLeaf() }))
    @$(".incomplete").checked = @model.get('complete')
    return this