Actions.Views.Templates ||= {}

class Actions.Views.Templates.EditView extends Backbone.View

  events:
    "click button"     : "publish"

  publish: ->
    $.post "/templates/#{@model.id}/publications.json", (data) ->
      if data._id
        window.location.replace("/publications/#{data._id}")


  render:  ->

    @children={}

    #rendering instructions title
    view = new Actions.Views.Templates.TemplateHeaderEditView(model: @model)
    $("section#templates").html(view.render().el)
    view["container"]=@
    @children['template_header']=view


    if @options.itemId?
      item = @model.items.get(itemId)
      rendarable= @template.items.byParentId(item.get('_id'))
      #breadcums
      view = new Actions.Views.Breadcrumbs.IndexView(template: template, item: item)
      view["container"]=@
      @children['breadcrams']=view
      $("section#items header").append(view.render().el)
      #parent_header
      view = new Actions.Views.Items.EditDetailsView({ model: item, template: template })
      view["container"]=@
      @children['parent_header']=view
      $("section#items header").append(view.render().el)
    else
      rendarable=@model.items.roots()

    #list of items
    view = new Actions.Views.Items.IndexView(template: @model, items: rendarable)
    view["container"]=@
    @children['items_index']=view
    $("section#templates").append(view.render().el)
    view = new Actions.Views.Items.NewView(template: @model, parentItem: item)
    view["container"]=@
    @children['new_item']=view
    $("section#items").append(view.render().el)

    @children.new_item.title().focus()

    @


