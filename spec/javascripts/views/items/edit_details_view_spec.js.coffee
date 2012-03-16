describe "Actions.Views.Items.EditDetailsView", ->
  beforeEach ->
    setFixtures('<div id="templates"></div>')
    @model = new Backbone.Model({ _id: 1, title: 'foo' })
    @template = new Backbone.Model({ _id: 1, title: 'bar' })
    @template.items = new Backbone.Collection()
    @view = new Actions.Views.Items.EditDetailsView(model: @model, template: @template)

  describe "Shortcuts", ->
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