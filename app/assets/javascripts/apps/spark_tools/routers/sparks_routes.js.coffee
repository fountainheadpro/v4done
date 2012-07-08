class Sparks.Routers.SparksRouter extends Backbone.Router
  initialize: (options) ->
    @sparks = new Actions.Collections.SparksCollection()
    @sparks.reset options.sparks

  routes:
    "new"                          : "new"
    "create"                       : "create"
    "index"                        : "index"
    "show"                         : "show"
    ".*"                           : "index"


  create: ->


  index: ->
