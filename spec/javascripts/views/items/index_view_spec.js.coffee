describe "Actions.Views.Items.IndexView", ->
  beforeEach ->
    @items = new Backbone.Collection()
    @view = new Actions.Views.Items.IndexView(items: @items)

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
      @item1 = new Backbone.Model({ id: 1, title: 'foo' })
      @item2 = new Backbone.Model({ id: 2, title: 'bar' })
      @view.options.items = new Backbone.Collection([@item1, @item2])
      @view.render()

    afterEach ->
      Actions.Views.Items.EditView.restore()

    it "create a Template view for each template item", ->
      expect(@editViewStub).toHaveBeenCalledTwice()
      expect(@editViewStub).toHaveBeenCalledWith({ model: @item1 })
      expect(@editViewStub).toHaveBeenCalledWith({ model: @item2 })

    it "prepends the template to the template list", ->
      expect($(@view.el).children().length).toEqual(2)

    it "returns the view object", ->
      expect(@view.render()).toEqual(@view)