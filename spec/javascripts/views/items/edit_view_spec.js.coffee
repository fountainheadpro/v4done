describe "Actions.Views.Items.EditView", ->
  beforeEach ->
    @model = new Backbone.Model({ _id: 1, title: 'foo' })
    @template = new Backbone.Model({ _id: 1, title: 'bar' })
    @view = new Actions.Views.Items.EditView(model: @model, template: @template)

  describe "Instantiation", ->
    it "creates a list item element", ->
      expect(@view.el.nodeName).toEqual("DIV")

    it "have a class of 'item'", ->
      expect($(@view.el)).toHaveClass('item')

  describe "Rendering", ->
    it "returns the view object", ->
      expect(@view.render()).toEqual(@view)

    describe "Template", ->
      beforeEach ->
        $("#templates").html(@view.render().el)

      it "has the correct title text", ->
        expect($(@view.el).find('textarea[name="title"]').val()).toEqual('foo')

  describe "Updating", ->
    beforeEach ->
      @modelSaveStub = sinon.stub(@model, 'save').returns(false)
      view2 = new Actions.Views.Items.EditView(model: new Backbone.Model({ _id: 2, title: 'baz', previous_id: null  }), template: @template)
      view3 = new Actions.Views.Items.EditView(model: new Backbone.Model({ _id: 3, title: 'qux', previous_id: 2  }), template: @template)
      new_view = new Actions.Views.Items.NewView(template: @template, parentItem: null)
      $("#templates").html(view2.render().el)
      $("#templates").prepend(view3.render().el)
      $("#templates").prepend(new_view.render().el)
      $("#templates").prepend(@view.render().el)

    afterEach ->
      @modelSaveStub.restore()

    it "should set correct previous_id", ->
      @view.update(jQuery.Event('keydown', { keyCode: 13, which: 13 }))
      expect(@modelSaveStub).toHaveBeenCalledOnce()
      expect(@modelSaveStub).toHaveBeenCalledWith({ description: '', title: 'foo', previous_id: 3})