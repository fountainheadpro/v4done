class Actions.Models.Item extends Backbone.Model
  idAttribute: "_id"

  defaults:
    title: null
    description: null
    parent_id: null
    previous_id: null

  isRoot: ->
    !@has('parent_id')

class Actions.Collections.ItemsCollection extends Backbone.Collection
  model: Actions.Models.Item
  url: '/items'

  roots: ->
    filteredItems = @select((item) -> return item.isRoot())
    return new Actions.Collections.ItemsCollection(filteredItems)

  byParentId: (parentId) ->
    filteredItems = @select((item) -> return item.get('parent_id') == parentId)
    return new Actions.Collections.ItemsCollection(filteredItems)

  byPreviousId: (previousId) ->
    filteredItems = @select (item) ->
      item.set('previous_id', null) if !item.get('previous_id')?
      return item.get('previous_id') == previousId
    return new Actions.Collections.ItemsCollection(filteredItems)