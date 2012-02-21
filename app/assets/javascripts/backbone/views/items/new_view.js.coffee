//= require backbone/mixins/movable
Actions.Views.Items||= {}

class Actions.Views.Items.NewView extends Backbone.View
  template: JST["backbone/templates/items/new"]
  className: 'item new_item'

  move: Actions.Mixins.Movable['move']
  focus_next: Actions.Mixins.Movable['focus_next']
  focus_prev: Actions.Mixins.Movable['focus_prev']

  events:
    "keydown textarea": "keymap"
    "focusin textarea": "highlight"

  constructor: (options) ->
    super(options)

  keymap: (e) ->
    switch e.keyCode
      when 38, 40 then @move(e)
      when 8 then @destroy(e)
      when 13 then @save(e)

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    title = @$("textarea[name='title']").val()
    description = @$("textarea[name='description']").val()
    parentId = @options.parentItem.get('_id') if @options.parentItem?
    @options.template.items.create({ title: title, description: description, parent_id: parentId },
      success: (item) =>
        @$('textarea[name="title"]').val('')
        @$('textarea[name="description"]').val('')
        view = new Actions.Views.Items.EditView({ model: item, template: @options.template, inList: true })
        $(@el).before(view.render().el)
        if e.keyCode != 13
          @destroy(e)
        else
          @$('textarea[name="title"]').focus()
    )

  destroy: (e) ->
    if @$('textarea[name="title"]').val() == '' && @$('textarea[name="description"]').val() == ''
      $(@el).unbind()
      @focus_prev() if e.keyCode == 8
      @remove()
      return false

  highlight: ->
    $('.selected textarea[name="description"]').each (i, item)->
      $(item).parent().hide() if $(item).val() == ''
    $('.selected').removeClass('selected')
    $(@el).addClass('selected')
    @$('.description').show()

  render: ->
    $(@el).html(@template())

    return this