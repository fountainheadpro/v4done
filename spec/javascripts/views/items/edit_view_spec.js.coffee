describe "Actions.Views.Items.EditView", ->
  beforeEach ->
    setFixtures('<div id="templates"></div>')
    @model = new Backbone.Model({ _id: 1, title: 'foo' })
    @template = new Backbone.Model({ _id: 1, title: 'bar' })
    @template.items = new Backbone.Collection()
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
      template = $("#templates")
      template.html(view2.render().el)
      template.append(view3.render().el)
      template.append(new_view.render().el)
      template.append(@view.render().el)

    afterEach ->
      @modelSaveStub.restore()

    it "should set correct previous_id", ->
      @view.update(jQuery.Event('keydown', { keyCode: 13, which: 13 }))
      expect(@modelSaveStub).toHaveBeenCalledOnce()
      expect(@modelSaveStub).toHaveBeenCalledWith({ description: '', title: 'foo', previous_id: 3})

  describe "Shortcuts", ->
    describe "shift + enter", ->
      beforeEach ->
        @viewUpdateStub = sinon.stub(@view, 'update')
        @viewGoToDetailsStub = sinon.stub(@view, 'goToItemDetails')
        @e = jQuery.Event('keydown', { keyCode: 13, which: 13, shiftKey: true });
        @view.keymap(@e)

      it "should save item", ->
        expect(@viewUpdateStub).toHaveBeenCalledOnce()
        expect(@viewUpdateStub).toHaveBeenCalledWith(@e)

      it "should go to details", ->
        expect(@viewGoToDetailsStub).toHaveBeenCalledOnce()
        expect(@viewGoToDetailsStub).toHaveBeenCalledWith(@template, @model)

    describe "shift + ↑", ->
      beforeEach ->
        @viewUpdateStub = sinon.stub(@view, 'update')
        @viewGoToParentStub = sinon.stub(@view, 'goToParentItem')
        sinon.stub(@template.items, 'get').returns(@model)
        @e = jQuery.Event('keydown', { keyCode: 38, which: 38, shiftKey: true });
        @view.keymap(@e)

      it "should save item", ->
        expect(@viewUpdateStub).toHaveBeenCalledOnce()
        expect(@viewUpdateStub).toHaveBeenCalledWith(@e)

      it "should go to details", ->
        expect(@viewGoToParentStub).toHaveBeenCalledOnce()
        expect(@viewGoToParentStub).toHaveBeenCalledWith(@template, @model)

    describe "shift + ↓", ->
      beforeEach ->
        @viewUpdateStub = sinon.stub(@view, 'update')
        @viewGoToDetailsStub = sinon.stub(@view, 'goToItemDetails')
        @e = jQuery.Event('keydown', { keyCode: 40, which: 40, shiftKey: true });
        @view.keymap(@e)

      it "should save item", ->
        expect(@viewUpdateStub).toHaveBeenCalledOnce()
        expect(@viewUpdateStub).toHaveBeenCalledWith(@e)

      it "should go to details", ->
        expect(@viewGoToDetailsStub).toHaveBeenCalledOnce()
        expect(@viewGoToDetailsStub).toHaveBeenCalledWith(@template, @model)
