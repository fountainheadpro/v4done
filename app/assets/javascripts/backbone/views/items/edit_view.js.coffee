//= require backbone/mixins/movable
Actions.Views.Items ||= {}

class Actions.Views.Items.EditView extends Backbone.View
  template: JST["backbone/templates/items/edit"]
  className: 'item'

  move: Actions.Mixins.Movable['move']

  events:
    "keydown textarea[name='title']": "keymap"
    "blur textarea[name='title']": "update"

  keymap: (e) ->
    switch e.keyCode
      when 38, 40 then @move(e)
      when 8 then @destroy(e)
      when 13 then @update(e)

  update: (e) ->
    e.preventDefault()
    e.stopPropagation()
    title = @$("textarea[name='title']").val()
    if @model.get('title') != title
      @model.save({ title: title },
        success: (item) => @model = item
      )
    if e.keyCode == 13
      if !$(@el).next('.item').hasClass('new_item')
        parentItem = @options.template.items.byParentId(@model.get('parent_id')) if @model.has('parent_id')
        view = new Actions.Views.Items.NewView(template: @options.template, parentItem: parentItem)
        $(@el).after(view.render().el)
      $(@el).next().find("textarea[name='title']").focus()

  destroy: () ->
    if @$('textarea').val() == ''
      @model.destroy()
      $(@el).unbind()
      $(@el).prev().find('textarea[name="title"]').focus()
      @remove()
      return false

  render: ->
    $(this.el).html(@template({ title: @model.get('title'), _id: @model.get('_id'), template_id: @options.template.get('_id'), subitemsCount: @options.subitemsCount}))
    return this