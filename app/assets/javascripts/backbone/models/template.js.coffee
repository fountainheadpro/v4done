class Actions.Models.Template extends Backbone.Model
  idAttribute: "_id"

  defaults:
    title: null

  initialize: ->
    if @has('items')
      @setItems(new Actions.Collections.ItemsCollection(@get('items')))
    else
      @setItems(new Actions.Collections.ItemsCollection())

  setItems: (items) ->
    @items = items

class Actions.Collections.TemplatesCollection extends Backbone.Collection
  model: Actions.Models.Template
  url: '/templates'