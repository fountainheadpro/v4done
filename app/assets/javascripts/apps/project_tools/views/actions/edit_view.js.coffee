Project.Views.Actions ||= {}

class Project.Views.Actions.EditView extends Backbone.View
  template: JST["apps/project_tools/templates/actions/edit"]

  events:
    "touch div.action": "show_sub_actions"
    "click div.action": "show_sub_actions"
    "click input.incomplete": "save_status"

  initialize: () ->
    @model.bind('change', @render, @)

  show_sub_actions: (e) ->
    #e.preventDefault()
    #e.stopPropagation()
    unless (@model.isLeaf())
      Project.router.navigate("#{@model.get('_id')}", { trigger: true })
    return false

  save_status: (e) ->
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