ProjectApp.Views.Actions ||= {}

class ProjectApp.Views.Actions.EditView extends Backbone.View
  template: JST["apps/project_tools/templates/actions/edit"]

  events:
    "touch div.action"       : "showSubactions"
    "click div.action"       : "showSubactions"
    "click input.incomplete" : "saveStatus"

  initialize: () ->
    @model.bind('change', @render, @)

  showSubactions: (e) ->
    #e.preventDefault()
    #e.stopPropagation()
    unless (@model.isLeaf())
      ProjectApp.router.navigate("#{@model.get('_id')}", { trigger: true })
    return false

  saveStatus: (e) ->
    e.preventDefault()
    e.stopPropagation()
    @model.toggle()

  attributes: ->
    { 'data-id': @model.id }

  render: ->
    $(@el).data('id', @model.get('id'))
    $(@el).html(@template({ title: @model.get('title'), description: @model.get('description'), id: @model.get('_id'), child_count: @model.get('child_count'), leaf: @model.isLeaf() }))
    @$(".incomplete").checked = @model.get('complete')
    return this