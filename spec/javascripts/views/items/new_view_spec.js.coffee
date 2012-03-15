describe "Actions.Views.Items.NewView", ->
  beforeEach ->
    @template = new Backbone.Model({ _id: 1, title: 'bar'})
    @template.items = new Backbone.Collection()
    @view = new Actions.Views.Items.NewView(template: @template, parentItem: null)

  describe "Creating", ->
    beforeEach ->
      @itemCreateStub = sinon.stub(@template.items, 'create').returns(false)
      view2 = new Actions.Views.Items.EditView(model: new Backbone.Model({ _id: 2, title: 'baz', previous_id: null  }), template: @template)
      view3 = new Actions.Views.Items.EditView(model: new Backbone.Model({ _id: 3, title: 'qux', previous_id: 2  }), template: @template)
      new_view = new Actions.Views.Items.NewView(template: @template, parentItem: null)
      template = $("#templates")
      template.html(view2.render().el)
      template.prepend(view3.render().el)
      template.prepend(new_view.render().el)
      template.prepend(@view.render().el)
      template.find(".new_item:last textarea[name='title']").val('foo')

    afterEach ->
      @itemCreateStub.restore()

    it "should set correct previous_id", ->
      @view.save(jQuery.Event('keydown', { keyCode: 13, which: 13 }))
      expect(@itemCreateStub).toHaveBeenCalledOnce()
      expect(@itemCreateStub).toHaveBeenCalledWith({ description: '', title: '', previous_id: 3, parent_id: undefined})