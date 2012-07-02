Actions.Views.Templates ||= {}

class Actions.Views.Templates.EditController extends Backbone.View

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

  renderable:->
    if @options.itemId?
      return @options.model.items.byParentId(@options.itemId).sortByPosition()
    else
      return @model.items.roots().sortByPosition()

  render:  ->

    @children={}
    @new_items={}

    #rendering instructions title
    view = new Actions.Views.Templates.TemplateHeaderEditView(model: @model)
    $("section#templates").html(view.render().el)
    view["container"]=@
    @children['template_header']=view

    #list of items
    view = new Actions.Views.Items.IndexView(template: @model, items: @renderable())
    view["container"]=@
    @children['items_index']=view
    $("section#templates").append(view.render().el)
    view = new Actions.Views.Items.NewView(
      template: @model,
      parentItem: @model.items.get(@options.itemId),
      previousId: @renderable()?.last()?.id)
    view["container"]=@
    if @renderable().length>0
      @new_items[@renderable().last().id]=view
    else
      @new_items["_"]=view
    $("section#items").append(view.render().el)
    view.title().focus()

    if @options.itemId?
      #breadcums
      view = new Actions.Views.Breadcrumbs.IndexView(template: @options.model, item: @model.items.get(@options.itemId))
      view["container"]=@
      @children['breadcrams']=view
      $("section#items header").append(view.render().el)
      #parent_header
      view = new Actions.Views.Items.EditDetailsView({ model: item, template: @options.model })
      view["container"]=@
      @children['parent_header']=view
      $("section#items header").append(view.render().el)
    @

  #down traversing logic
  next_item: (e)->
    # next request came from edit view
    if e.id?
      next_item=@options.model.items.get(e.id).next()
      if next_item?
        @children[next_item.id].title().focus()
      else
        @new_items[@renderable().last().id].title().focus()
      return
    # next request came from new view
    if e.previous_id?
      next_item=@model.items.get(e.previous_id).next()
      if next_item?
        @children[next_item.id].title().focus()
      return
    #request came from the title we are in details view jump from the title to the parent header
    if @children.parent_header?
      @children.parent_header.title().focus
      return
    #request came from the title jump from the title to the first item
    @children[@renderable().first().id]?.title().focus()

  #up traversing logic
  prev_item: (e)->
    #came from new item - it's pointing to prev item
    if e.previous_id?
      @children[e.previous_id].title().focus()
    else
      #came from edit view
      prev_item=@model.items.get(e.id).prev()
      if prev_item? #if there is a previous item
        if @new_items[prev_item.id]?
          @new_items[prev_item.id].title().focus()
        else
          @children[prev_item.id].title().focus()
      else #if it's a last item
        if @children.parent_header?
          @children.parent_header.title().focus
        else
          @children.template_header.title().focus()

  destroy: (e) ->
    #moving cursor to the previous item
    @prev_item(e)
    #removing editable item
    if e.id?
      item=@model.items.get(e.id)
      if @new_items[e.id]?
        @new_items[item.get('previous_id')] = @new_items[e.id]
        delete @new_items[e.id]
      v=@children[e.id]
      item.destroy()  if item?
    #removing new view item
    if e.previous_id?
      v=@new_items[e.previous_id]
      delete @new_items[e.previous_id]
    v.remove()
    return false

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

  new_item_saved: (e) ->
    if @new_items["_"]?
      @new_items[e.item.id]=@new_items["_"]
      delete @new_items["_"]
    else
      @new_items[e.item.id]=@new_items[e.item.get('previous_id')]
      @new_items[e.item.get('previous_id')]=null
    view = new Actions.Views.Items.EditView({ model: e.item, template: @model})
    @new_items[e.item.id].$el.before(view.render().el)
    @new_items[e.item.id].$el.data('previous_id',e.item.id)
    @children[e.item.id]=view
    view.container=@
    if e.item.next()?
      @new_items[e.item.id].remove()
      delete @new_items[e.item.id]
      @children[e.item.next().id].title().focus()

  parent_item: (e)->
    console.log(e)

  child_items: (e)->
    console.log(e)

  item_details: (e)->
    console.log(e)
