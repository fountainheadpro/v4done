describe "Actions.Views.Breadcrumbs.IndexView", ->
  beforeEach ->
    @view = new Actions.Views.Breadcrumbs.IndexView({ template: new Backbone.Model(), item: null })

  describe "Instantiation", ->
    it "creates a list element", ->
      expect(@view.el.nodeName).toEqual("UL")

    it "have a class of 'breadcrumb'", ->
      expect($(@view.el)).toHaveClass('breadcrumb')

  describe "Rendering", ->
    beforeEach ->
      @breadcrumbView = new Backbone.View()
      @breadcrumbView.render = ->
        @el = document.createElement('li')
        return this
      @templateRenderSpy = sinon.spy(@breadcrumbView, "render");
      @breadcrumbViewStub = sinon.stub(Actions.Views.Breadcrumbs, "BreadcrumbView").returns(@breadcrumbView)
      @template = new Backbone.Model({ _id: 1, title: 'foo' })
      @item = new Backbone.Model({ _id: 2, title: 'bar' })
      @view.options.template = @template
      @view.options.item = @item
      @view.render()

    afterEach ->
      Actions.Views.Breadcrumbs.BreadcrumbView.restore()

    it "create a Breadcrumb view for all templates and current template", ->
      expect(@breadcrumbViewStub).toHaveBeenCalledOnce()
      expect(@breadcrumbViewStub).toHaveBeenCalledWith({ title: 'foo', link: '#1/items', active: false })

    it "prepends the template to the template list", ->
      expect($(@view.el).children().length).toEqual(1)

    it "returns the view object", ->
      expect(@view.render()).toEqual(@view)
