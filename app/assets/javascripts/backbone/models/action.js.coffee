class Actions.Models.Action extends Backbone.Model

  idAttribute: "_id"

  paramRoot: '_action'


  defaults:
    title: null
    notes: null
    created_at: null
    creator: null
  
class Actions.Collections.ActionsCollection extends Backbone.Collection
  model: Actions.Models.Action
  url: '/actions'