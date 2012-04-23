class ProjectApp.Models.Project extends Backbone.Model
  idAttribute: "_id"

  defaults:
    title: ''
    description: ''

  initialize: ->
    @actions = new ProjectApp.Collections.ActionsCollection()
    @setActionsUrl()
    if @has('actions')
      @actions.reset(@get('actions'))
      @unset('actions')

  setActionsUrl: ->
    @actions.url = "/projects/#{@get('_id')}/actions"