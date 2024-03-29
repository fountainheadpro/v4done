class Actions.Models.Item extends Backbone.Model
  idAttribute: "_id"

  defaults:
    title: null
    description: null
    parent_id: null
    previous_id: null

  isRoot: ->
    !@has('parent_id')

  prev: ->
    @collection.previous(@)

  next: ->
    @collection.next(@)

  destroy:(options) ->
    @next()?.set({previous_id: @prev()?.id}, {silent: true})
    super(options)


class Actions.Collections.ItemsCollection extends Backbone.Collection
  model: Actions.Models.Item
  url: '/items'

  constructor: (items)->
    super(items)
    @head= _.last(items) if items?

  roots: ->
    filteredItems = @select((item) -> return item.isRoot())
    return new Actions.Collections.ItemsCollection(filteredItems)

  byParentId: (parentId) ->
    filteredItems = @select((item) -> return item.get('parent_id') == parentId)
    return new Actions.Collections.ItemsCollection(filteredItems)

  #depricated to remove
  byPreviousId: (previousId) ->
    filteredItems = @select (item) ->
      item.set('previous_id', null, {silent: true}) if !item.get('previous_id')?
      return item.get('previous_id') == previousId
    return new Actions.Collections.ItemsCollection(filteredItems)

  previous: (item) ->
    previous_id=item.get('previous_id')
    @get(previous_id)  if previous_id?

  next: (item) ->
    parent_id=item.parent_id || null
    _.first(@.where({parent_id: parent_id, previous_id: item.id}))

  last:->
    @head

  create: (model,options)->
    success_handler=options.success
    options.success=(item)=>
      prev_items=@.where({parent_id: item.get('parent_id'), previous_id: item.get('previous_id')})
      _.each(prev_items, (pi)=>
        pi.set({previous_id: item.id}, {silent: true}) unless pi.id==item.id
      )
      success_handler(item)
    super(model,options)

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

  first: ->
    _.first(@.where({previous_id: null}))


  saveSortOrder: (id, new_prev_item, new_next_item) ->
    #get all items pointing to this item
    moved_item=@get(id)
    oldPrevId=moved_item.get("previous_id")
    oldPrevItem=@get(oldPrevId)
    @byPreviousId(id).each (item) =>
      if oldPrevId
          item.set("previous_id", oldPrevItem.id)
      else
          item.set("previous_id",null)
      item.save()
    if new_prev_item
      moved_item.set("previous_id", new_prev_item)
    else
      moved_item.set("previous_id", null)
    moved_item.save()
    if new_next_item
      next_item=@get(new_next_item).set("previous_id", id)
      next_item.save()





