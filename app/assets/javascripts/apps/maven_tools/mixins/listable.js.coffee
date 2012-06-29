Actions.Mixins.Listable ||= {}
Actions.Mixins.Listable =

  next: ()->
    item_id=@$el.attr('data-id')
    item = @model.collection.get(item_id)
    next_item=@model.collection.next(item)
    $("div[data-id=" + next_item.id + "]")

  prev: ()->
    item_id=@$el.attr('data-id')
    item = @model.collection.get(item_id)
    prev_item=@model.collection.prev(item)
    $("div[data-id="+ prev_item.id +"]")

  title: ->
    @$el.find('[name=title]')

  description: ->
    @$el.find('[name=description]')
