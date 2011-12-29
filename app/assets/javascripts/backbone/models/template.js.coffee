class Actions.Models.Template extends Backbone.Model
  idAttribute: "_id"

  defaults:
    title: null

  initialize: ->
    @items = new Actions.Collections.ItemsCollection()
    @items.url = "/templates/#{@get('id')}/items"
    if @has('items')
      @items.reset(@get('items'))

class Actions.Collections.TemplatesCollection extends Backbone.Collection
  model: Actions.Models.Template
  url: '/templates'