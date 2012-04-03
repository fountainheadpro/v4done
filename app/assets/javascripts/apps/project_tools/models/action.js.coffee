class ProjectApp.Models.Action extends Backbone.Model
  idAttribute: "_id"

  defaults:
    title: null
    description: null
    parent_id: null
    previous_id: null
    child_count: 0

  isRoot: ->
    !@has('parent_id')

  isLeaf: ->
    (@get('child_count') == 0)

  toggle: ->
    @.save({completed: !@.get('completed')});

class ProjectApp.Collections.ActionsCollection extends Backbone.Collection
  model: ProjectApp.Models.Action
  url: 'actions'

  roots: ->
    filteredItems = @select((action) -> return action.isRoot())
    return new ProjectApp.Collections.ActionsCollection(filteredItems)

  byParentId: (parentId) ->
    filteredItems = @select((action) -> return action.get('parent_id') == parentId)
    return new ProjectApp.Collections.ActionsCollection(filteredItems)

  byPreviousId: (previousId) ->
    filteredItems = @select((action) -> return action.get('previous_id') == previousId)
    return new ProjectApp.Collections.ActionsCollection(filteredItems)

