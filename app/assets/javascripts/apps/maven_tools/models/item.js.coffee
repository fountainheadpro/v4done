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

  sortByPosition: (previousId = null) ->
    sortedItems = []
    @byPreviousId(previousId).each (item) =>
      sortedItems.push item
      sortedItems.push @sortByPosition(item.get('_id'))
    if previousId?
      return _.flatten(sortedItems)
    else
      sortedItems = _(sortedItems).flatten()
      if sortedItems.length < @.length
        sortedItems.push(@.without.apply(@, sortedItems))
      return new Actions.Collections.ItemsCollection(_.flatten(sortedItems))

  saveSortOrder: (id, new_prev_item) ->
    #get all items pointing to this item
    oldPrevId=@get(id).get("previousId")
    oldPrevItem=@get(oldPrevId)
    if oldPrevId
      @byPreviousId(id).each (item) =>
        item.set("previous_id", oldPrevItem.id)
        item.save()
    @get(id).set("previous_id", new_prev_item)
    @get(id).save()

    #@byPreviousId(id).each (item) =>




