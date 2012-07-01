Actions.Views.Items||= {}

class Actions.Views.Items.NewView extends Actions.Views.Items.BaseItemView
  template: JST["apps/maven_tools/templates/items/new"]
  className: 'item new_item'
  view_name: 'new_item'

  goToParentItem: Actions.Mixins.GoTo['parentItem']
  goToItemDetails: Actions.Mixins.GoTo['itemDetails']
  title: Actions.Mixins.CommonElements.title
  description: Actions.Mixins.CommonElements.description

  events:
    "keydown .editable": "keymap"
    "blur .editable": "save"
    "focusin .editable": "highlight"
    "click i.destroy" : "destroy"

  keymap: (e) ->
    if e.shiftKey
      switch e.which
        when 38 then @goToParentItem(@options.template, @options.parentItem)
        when 13,40 then @save(e, true)
    else
      switch e.keyCode
        when 38 then @container.$el.trigger({type: "prev_item", previous_id: @$el.data('previous_id') })
        when 40 then @container.$el.trigger({type: "next_item", previous_id: @$el.data('previous_id') })
        when 8 then @destroy(e)
        when 13 then @save(e, false)

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



  highlight: ->
    $('.selected textarea[name="description"]').each (i, item)->
      $(item).parent().hide() if $(item).val() == ''
    $('.selected').removeClass('selected')
    $(@el).addClass('selected')
    @$('.description').show()

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
