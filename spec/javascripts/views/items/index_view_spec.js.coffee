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
      @itemView = new Backbone.View()
      @itemView.render = ->
        @el = document.createElement('li')
        return this
      @itemRenderSpy = sinon.spy(@itemView, "render");
      @itemViewStub = sinon.stub(Actions.Views.Items, "ItemView").returns(@itemView)
      @item1 = new Backbone.Model({ id: 1, title: 'foo' })
      @item2 = new Backbone.Model({ id: 2, title: 'bar' })
      @view.options.items = new Backbone.Collection([@item1, @item2])
      @view.render()

    afterEach ->
      Actions.Views.Items.ItemView.restore()

    it "create a Template view for each template item", ->
      expect(@itemViewStub).toHaveBeenCalledTwice()
      expect(@itemViewStub).toHaveBeenCalledWith({ model: @item1 })
      expect(@itemViewStub).toHaveBeenCalledWith({ model: @item2 })

    it "prepends the template to the template list", ->
      expect($(@view.el).children().length).toEqual(2)

    it "returns the view object", ->
      expect(@view.render()).toEqual(@view)