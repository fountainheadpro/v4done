Project.Views.Actions ||= {}

class Project.Views.Actions.EditView extends Backbone.View
  template: JST["apps/project_tools/templates/actions/edit"]

  events:
    "touch div.action": "show_sub_actions"
    "click div.action": "show_sub_actions"
    "click input.incomplete": "save_status"

  show_sub_actions: (e) ->
    #e.preventDefault()
    #e.stopPropagation()
    unless (@model.isLeaf())
      Project.router.navigate("#{@model.get('_id')}", {trigger: true})
    return false

  save_status: (e) ->
    e.preventDefault()
    e.stopPropagation()
    @model.save({ completed: true, _id: @model.id, project_id: @options.project.id},
            success: (item) => @model = item
          )

  attributes: ->
    { 'data-id': @model.id }

  render: ->
    $(@el).data('id', @model.get('_id'))
    $(@el).html(@template({ title: @model.get('title'), checked: @model.get('completed'), description: @model.get('description'), id: @model.get('_id'), child_count: @model.get('child_count'), leaf: @model.isLeaf()}))
    return this