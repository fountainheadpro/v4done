describe "Actions.Views.Items.IndexView", ->
  beforeEach ->
    @items = new Backbone.Collection()
    @template = new Backbone.Model({_id: 1})
    @template.items = @items
    @view = new Actions.Views.Items.IndexView(template: @template, items: @items)

  describe "Instantiation", ->
    it "creates a div element", ->
      expect(@view.el.nodeName).toEqual("DIV")

    it "have a class of 'row'", ->
      expect($(@view.el)).toHaveClass('row')

    it "have a id of 'unstyled'", ->
      expect($(@view.el)).toHaveId('items')

  describe "Rendering", ->
    beforeEach ->
      @editView = new Backbone.View()
      @editView.render = ->
        @el = document.createElement('li')
        return this
      @itemRenderSpy = sinon.spy(@editView, "render");
      @editViewStub = sinon.stub(Actions.Views.Items, "EditView").returns(@editView)
      @item1 = new Backbone.Model({ _id: 1, title: 'foo', previous_id: null })
      @item2 = new Backbone.Model({ _id: 2, title: 'bar', previous_id: 1 })
      @item3 = new Backbone.Model({ _id: 3, title: 'foo2', previous_id: null }) # it should be rendred
      @item4 = new Backbone.Model({ _id: 4, title: 'bar2', previous_id: 1 }) # and this too
      @items = new Backbone.Collection([@item1, @item2, @item3, @item4])
      @items.byParentId = -> return new Backbone.Collection(0)
      @items.byPreviousId = (previousId) =>
        if previousId == null
          return new Backbone.Collection([@item1, @item3])
        else if previousId == 1
          return new Backbone.Collection([@item2, @item4])
        else
          return new Backbone.Collection(0)

      @template.items = @items
      @view.options.items = @items
      @view.options.template = @template
      @view.render()

    afterEach ->
      Actions.Views.Items.EditView.restore()

    it "create a item view for each item", ->
      expect(@editViewStub.callCount).toEqual(4)
      expect(@editViewStub).toHaveBeenCalledWith({ model: @item1, template: @template })
      expect(@editViewStub).toHaveBeenCalledWith({ model: @item2, template: @template })
      expect(@editViewStub).toHaveBeenCalledWith({ model: @item3, template: @template })
      expect(@editViewStub).toHaveBeenCalledWith({ model: @item4, template: @template })

    it "prepends the item to the item list", ->
      expect($(@view.el).children().length).toEqual(4)

    it "returns the view object", ->
      expect(@view.render()).toEqual(@view)