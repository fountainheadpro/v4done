Project.Views.Actions ||= {}

class Project.Views.Actions.EditView extends Backbone.View
  template: JST["apps/project_tools/templates/actions/edit"]

  events:
    "onmouseover a": "prevent_default"
    "touchstart div.action": "prevent_default"
    "load window": "full_screen"

  prevent_default: (e) ->
    e.preventDefault()
    e.stopPropagation()
    return false

  full_screen: (e) ->
    window.scrollTo(0,1);

  attributes: ->
    { 'data-id': @model.id }

  render: ->
    $(@el).data('id', @model.get('_id'))
    $(@el).html(@template({ title: @model.get('title'), checked: @model.get('completed'), description: @model.get('description'), id: @model.get('_id'), child_count: @model.get('child_count'), leaf: @model.isLeaf(), url:"#"}))
    return this