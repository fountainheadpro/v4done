Actions.Mixins.GoTo ||= {}
Actions.Mixins.GoTo =
  parentItem: (template, item) ->
    if !item? || item.isRoot()
      Actions.router.navigate("#{template.id}/items", {trigger: true})
    else
      Actions.router.navigate("#{template.id}/items/#{item.get('parent_id')}/items", {trigger: true})

  itemDetails: (template, item) ->
    Actions.router.navigate("#{template.id}/items/#{item.id}/items", {trigger: true})