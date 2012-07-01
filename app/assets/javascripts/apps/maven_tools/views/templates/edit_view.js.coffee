Actions.Views.Templates ||= {}

class Actions.Views.Templates.EditView extends Backbone.View

  tagName: 'section'

  events:
    "click button" : "publish"
    "new_item": "new_item"
    "next_item": "next_item"
    "prev_item": "prev_item"
    "parent_item": "parent_item"
    "item_details": "item_details"
    "destroy" : "destroy"
    "new_item_saved" : "new_item_saved"

  publish: ->
    $.post "/templates/#{@model.id}/publications.json", (data) ->
      if data._id
        window.location.replace("/publications/#{data._id}")


  render:  ->

    @children={}
    @new_items={}

    #rendering instructions title
    view = new Actions.Views.Templates.TemplateHeaderEditView(model: @model)
    $("section#templates").html(view.render().el)
    view["container"]=@
    @children['template_header']=view

    #building renderable data
    if @options.itemId?
      item = @model.items.get(@options.itemId)
      @renderable= @options.model.items.byParentId(@options.itemId).sortByPosition()
    else
      @renderable=@model.items.roots().sortByPosition()

    #list of items
    view = new Actions.Views.Items.IndexView(template: @model, items: @renderable)
    view["container"]=@
    @children['items_index']=view
    $("section#templates").append(view.render().el)
    view = new Actions.Views.Items.NewView(template: @model, parentItem: item, previousId: @renderable?.last()?.id)
    view["container"]=@
    if @renderable.length>0
      @new_items[@renderable.last().id]=view
    else
      @new_items["_"]=view
    $("section#items").append(view.render().el)
    view.title().focus()

    if @options.itemId?
      #breadcums
      view = new Actions.Views.Breadcrumbs.IndexView(template: @options.model, item: item)
      view["container"]=@
      @children['breadcrams']=view
      $("section#items header").append(view.render().el)
      #parent_header
      view = new Actions.Views.Items.EditDetailsView({ model: item, template: @options.model })
      view["container"]=@
      @children['parent_header']=view
      $("section#items header").append(view.render().el)
    @

  new_item: (e)->
    v=@children[e.id]
    c=@options.model.items
    i=c.get(e.id)
    unless $(v.el).next('.item').hasClass('new_item')
      parentItem = c.get(i.get('parent_id')) if i.has('parent_id')
      view = new Actions.Views.Items.NewView(template: @model, parentItem: parentItem, previousId: e.id)
      view.container=@
      @new_items[e.id]=view
      $(v.el).after(view.render().el)
      view.title().focus()
    else
      @new_items[e.id].title().focus()

  next_item: (e)->
    if e.id?
      next_item=@options.model.items.get(e.id).next()
      if next_item?
        @children[next_item.id].title().focus()
      else
        @new_items[@renderable.last().id].title().focus()
      return

    if e.previous_id?
      next_item=@model.items.get(e.previous_id).next()
      if next_item?
        @children[next_item.id].title().focus()
      return

    if @children.parent_header?
      @children.parent_header.title().focus
      return

    @children[@options.model.items.first().id]?.title().focus()

  prev_item: (e)->
    if e.previous_id?
      @children[e.previous_id].title().focus()
    else
      prev_item=@model.items.get(e.id).prev()
      if prev_item?
        if @new_items[prev_item.id]?
          @new_items[prev_item.id].title().focus()
        else
          @children[prev_item.id].title().focus()
      else
        if @children.parent_header?
          @children.parent_header.title().focus
        else
          @children.template_header.title().focus()

  destroy: (e) ->
    @prev_item(e)
    if e.id?
      item=@model.items.get(e.id)
      item.destroy()  if item?
      v=@children[e.id]
    if e.previous_id?
      v=@new_items[e.previous_id]
    v.$el.unbind()
    v.remove()
    return false

  new_item_saved: (e) ->
    if @new_items["_"]?
      @new_items[e.item.id]=@children["_"]
      @new_items["_"]=null
    else
      @new_items[e.item.id]=@new_items[e.item.get('previous_id')]
      @new_items[e.item.get('previous_id')]=null
    view = new Actions.Views.Items.EditView({ model: e.item, template: @model})
    @new_items[e.item.id].$el.before(view.render().el)
    @new_items[e.item.id]=view
    view.container=@
    if e.item.next()?
      @new_items[e.item.id].remove()
      @new_items[e.item.id]=null
      @children[e.item.next().id].title().focus()


  parent_item: (e)->
    console.log(e)

  child_items: (e)->
    console.log(e)

  item_details: (e)->
    console.log(e)

  last_child: ->
    @children[_.last(@item_ids)]

  first_child: ->
    @children[_.first(@item_ids)]