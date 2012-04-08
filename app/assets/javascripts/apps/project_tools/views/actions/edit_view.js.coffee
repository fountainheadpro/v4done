ProjectApp.Views.Actions ||= {}

class ProjectApp.Views.Actions.EditView extends Backbone.View
  template: JST["apps/project_tools/templates/actions/edit"]
  className: "action row-fluid"

  events:
    "mousedown"               : "highlight"
    "touchstart"              : "highlight"
    "thouchend"               : "unhighlight"
    "mouseup"                 : "unhighlight"
    "touch div.action-info"   : "showSubactions"
    "click div.action-info"   : "showSubactions"
    "click input.status"      : "saveStatus"
    "click div.action-status" : "saveStatus"
    "swipe"                   : "saveStatus"


  initialize: () ->
    @model.bind('change', @render, @)

  highlight: ->
    unless @model.isLeaf()
      $(@el).addClass('active')

  unhighlight: ->
    $(@el).removeClass('active')

  showSubactions: (e) ->
    unless @model.isLeaf()
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
    $(@el).toggleClass('completed', @model.isCompleted())
    $(@el).html(@template({ title: @model.get('title'), description: @model.get('description'), id: @model.get('_id'), child_count: @model.get('child_count'), leaf: @model.isLeaf(), completed: @model.get('completed') }))
    return this