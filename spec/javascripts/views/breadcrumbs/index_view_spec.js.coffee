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
      @view.options.template = @template
      @view.render()

    afterEach ->
      Actions.Views.Breadcrumbs.BreadcrumbView.restore()

    it "create a Breadcrumb view for all templates and current template", ->
      expect(@breadcrumbViewStub).toHaveBeenCalledTwice()
      expect(@breadcrumbViewStub).toHaveBeenCalledWith({ title: 'Goals', link: '#/index', active: false })
      expect(@breadcrumbViewStub).toHaveBeenCalledWith({ title: '', link: '', active: true })

    it "prepends the template to the template list", ->
      expect($(@view.el).children().length).toEqual(2)

    it "returns the view object", ->
      expect(@view.render()).toEqual(@view)
