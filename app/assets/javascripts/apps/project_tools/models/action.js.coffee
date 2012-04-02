class Project.Models.Action extends Backbone.Model
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
    @.save({complete: !@.get('complete')});




class Project.Collections.ActionsCollection extends Backbone.Collection
  model: Project.Models.Action
  url: 'actions'

  roots: ->
    filteredItems = @select((action) -> return action.isRoot())
    return new Project.Collections.ActionsCollection(filteredItems)

  byParentId: (parentId) ->
    filteredItems = @select((action) -> return action.get('parent_id') == parentId)
    return new Project.Collections.ActionsCollection(filteredItems)

  byPreviousId: (previousId) ->
    filteredItems = @select((action) -> return action.get('previous_id') == previousId)
    return new Project.Collections.ActionsCollection(filteredItems)

