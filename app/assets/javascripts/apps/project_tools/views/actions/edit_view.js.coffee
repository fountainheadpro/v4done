Project.Views.Actions ||= {}

class Project.Views.Actions.EditView extends Backbone.View
  template: JST["apps/project_tools/templates/actions/edit"]

  events:
    "touchstart div.action": "show_sub_actions"
    "click div.action": "show_sub_actions"

  show_sub_actions: (e) ->
    #e.preventDefault()
    #e.stopPropagation()
    unless (@model.isLeaf())
      Project.router.navigate("#{@model.get('_id')}", {trigger: true})
    return false

  attributes: ->
    { 'data-id': @model.id }

  render: ->
    $(@el).data('id', @model.get('_id'))
    $(@el).html(@template({ title: @model.get('title'), checked: @model.get('completed'), description: @model.get('description'), id: @model.get('_id'), child_count: @model.get('child_count'), leaf: @model.isLeaf()}))
    return this