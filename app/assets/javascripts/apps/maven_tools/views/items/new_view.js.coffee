Actions.Views.Items||= {}

class Actions.Views.Items.NewView extends Actions.Views.Items.BaseItemView
  template: JST["apps/maven_tools/templates/items/new"]
  className: 'item new_item'
  view_name: 'new_item'

  goToParentItem: Actions.Mixins.GoTo['parentItem']
  goToItemDetails: Actions.Mixins.GoTo['itemDetails']
  focus_prev: Actions.Mixins.Navigatable['focus_prev']
  title: Actions.Mixins.CommonElements.title
  description: Actions.Mixins.CommonElements.description

  events:
    "keydown .editable": "keymap"
    "focusin .editable": "highlight"
    "click i.destroy" : "destroy"

  keymap: (e) ->
    if e.shiftKey
      switch e.which
        when 38 then @goToParentItem(@model.template, @model.parentItem)
        when 13,40 then @save(e, true)
    else
      switch e.keyCode
        when 38 then @focus_prev()
        when 8 then @destroy(e)
        when 13 then @save(e, false)

  save: (e,details) ->
    e.preventDefault()
    e.stopPropagation()

    title = @title().val()
    description = @description().val()
    parentId = @options.parentItem.get('_id') if @options.parentItem?
    previousId = @prev().data('id')
    @options.template.items.create({ title: title, description: description, parent_id: parentId, previous_id: previousId },
      success: (item) =>
        if details
          @goToItemDetails(@model.template, item)
        else
          @title().val('')
          @description().val('')
          view = new Actions.Views.Items.EditView({ model: item, template: @options.template})
          $(@el).before(view.render().el)
          if e.keyCode != 13
            @destroy(e)
          else
            @title().focus()
    )


  highlight: ->
    $('.selected textarea[name="description"]').each (i, item)->
      $(item).parent().hide() if $(item).val() == ''
    $('.selected').removeClass('selected')
    $(@el).addClass('selected')
    @$('.description').show()

  render: ->
    $(@el).html(@template())
    @description().action_editor()
    @