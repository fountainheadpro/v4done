class Actions.Models.Project extends Backbone.Model
  idAttribute: "_id"

  defaults:
    title: ''
    description: ''

  initialize: ->
    @items = new Actions.Collections.ActionsCollection()
    @setActionsUrl()
    if @has('actions')
      @items.reset(@get('actions'))
      @unset('actions')

  setActionsUrl: ->
    @items.url = "/project/#{@get('_id')}/actions"
