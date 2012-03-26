class Project.Models.Action extends Backbone.Model
  idAttribute: "_id"

  defaults:
    title: null
    description: null
    parent_id: null
    previous_id: null
    items_count: 0

  isRoot: ->
    !@has('parent_id')

  isLeaf: ->
    child_count < 1


class Project.Collections.ActionsCollection extends Backbone.Collection
  model: Project.Models.Action
  url: '/actions'

  byParentId: (parentId) ->
    filteredItems = @select((action) -> return action.get('parent_id') == parentId)
    return new Project.Collections.ActionsCollection(filteredItems)

  byPreviousId: (previousId) ->
    filteredItems = @select((action) -> return action.get('previous_id') == previousId)
    return new Project.Collections.ActionsCollection(filteredItems)