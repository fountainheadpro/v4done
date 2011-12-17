class Actions.Models.Item extends Backbone.Model
  idAttribute: "_id"

  defaults:
    title: null

class Actions.Collections.ItemsCollection extends Backbone.Collection
  model: Actions.Models.Item
  url: '/items'