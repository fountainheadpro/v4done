class Actions.Models.Template extends Backbone.Model
  idAttribute: "_id"

  defaults:
    title: null

  initialize: ->
    if @has('items')
      items = new Actions.Collections.ItemsCollection().reset(@get('items'))
      @setItems(items)

  setItems: (items) ->
    @items = items

class Actions.Collections.TemplatesCollection extends Backbone.Collection
  model: Actions.Models.Template
  url: '/templates'