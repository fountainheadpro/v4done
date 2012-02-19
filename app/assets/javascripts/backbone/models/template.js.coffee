class Actions.Models.Template extends Backbone.Model
  idAttribute: "_id"

  defaults:
    title: ''
    description: ''

  initialize: ->
    @items = new Actions.Collections.ItemsCollection()
    @items.url = "/templates/#{@get('_id')}/items"
    if @has('items')
      @items.reset(@get('items'))
      @unset('items')

class Actions.Collections.TemplatesCollection extends Backbone.Collection
  model: Actions.Models.Template
  url: '/templates'