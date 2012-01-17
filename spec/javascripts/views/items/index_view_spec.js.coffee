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
      @item1 = new Backbone.Model({ _id: 1, title: 'foo' })
      @item2 = new Backbone.Model({ _id: 2, title: 'bar' })
      @items = new Backbone.Collection([@item1, @item2])
      @items.byParentId = -> return new Backbone.Collection(0)
      @template.items = @items
      @view.options.items = @items
      @view.options.template = @template
      @view.render()

    afterEach ->
      Actions.Views.Items.EditView.restore()

    it "create a item view for each item", ->
      expect(@editViewStub).toHaveBeenCalledTwice()
      expect(@editViewStub).toHaveBeenCalledWith({ model: @item1, template_id: 1, subitemsCount: 0 })
      expect(@editViewStub).toHaveBeenCalledWith({ model: @item2, template_id: 1, subitemsCount: 0 })

    it "prepends the item to the item list", ->
      expect($(@view.el).children().length).toEqual(2)

    it "returns the view object", ->
      expect(@view.render()).toEqual(@view)