Project.Views.Actions ||= {}

class Project.Views.Actions.EditView extends Backbone.View
  template: JST["apps/project_tools/templates/actions/edit"]

  attributes: ->
    { 'data-id': @model.id }

  render: ->
    $(@el).data('id', @model.get('_id'))
    $(@el).html(@template({ title: @model.get('title'), checked: @model.get('completed'), description: @model.get('description'), id: @model.get('_id'), leaf:@model.isLeaf, url:"#"}))
    return this