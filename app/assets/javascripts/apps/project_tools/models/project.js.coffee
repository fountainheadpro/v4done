class Project.Models.Project extends Backbone.Model
  idAttribute: "_id"

  defaults:
    title: ''
    description: ''

  initialize: ->
    @actions = new Project.Collections.ActionsCollection()
    @setActionsUrl()
    if @has('actions')
      @actions.reset(@get('actions'))
      @unset('actions')

  setActionsUrl: ->
    @items.url = "/project/#{@get('_id')}/actions"
