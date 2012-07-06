Actions.Views.Items||= {}

class Actions.Views.Items.NewView extends Actions.Views.Items.BaseItemView
  template: JST["apps/maven_tools/templates/items/new"]
  className: 'item new_item'
  view_name: 'new_item'

  child_events:
    "click i.destroy" : "destroy"

  events: _.extend(_.clone(Actions.Views.Items.BaseItemView::base_events), NewView::child_events)

  save: (e,details) ->
    e.preventDefault()
    e.stopPropagation()
    title = @title().val()
    return if title.length==0
    description = @description().val()
    parentId = @options.parentItem.get('_id') if @options.parentItem?
    @options.template.items.create({ title: title, description: description, parent_id: parentId, previous_id: @$el.data('previous_id') },
      success: (item) =>
        if details
          @container.$el.trigger("item_details")#@goToItemDetails(@model.template, item)
        else
          @title().val('')
          @description().val('')
          $(@el).data('id')
          $(@el).data('previous_id', null)
          @container.$el.trigger({type: "new_item_saved", item: item})
          if e.keyCode == 13
            @container.trigger({type: "new_item", id: item.id})
    )

  save: (e)->
    super(e)
    if e.which == 13 && !e.shiftKey
      @container.$el.trigger({type: "new_item", id: @model.id})

  render: ->
    $(@el).html(@template())
    $(@el).data('previous_id', @options.previousId)
    @description().action_editor()
    @

  destroy: (e) ->
    backspase = e.which == 8
    if (@title().val() == '' && @description().html() == '')
      e.preventDefault()
      e.stopPropagation()
      @container.$el.trigger({type: "destroy", previous_id: @$el.data('previous_id') })
