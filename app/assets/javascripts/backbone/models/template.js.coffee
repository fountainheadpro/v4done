class Actions.Models.Template extends Backbone.Model
  idAttribute: "_id"

  defaults:
    title: null
  
class Actions.Collections.TemplatesCollection extends Backbone.Collection
  model: Actions.Models.Template
  url: '/templates'