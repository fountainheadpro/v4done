describe "Template model", ->
  describe "when instantiated", ->
    describe "with items", ->
      it "should exhibit attributes", ->
        t = new Actions.Models.Template({
          id: 1,
          title: 'Apple Pie',
          items: [{
            id: 1,
            title: 'Ingredients',
          }, {
            id: 2,
            title: 'Directions'
          }]
        })
        expect(t.get('title')).toEqual('Apple Pie')
        expect(t.items.length).toEqual(2)
        expect(t.items.at(0).get('title')).toEqual('Ingredients')
        expect(t.items.at(1).get('title')).toEqual('Directions')
        expect(t.items.url).toEqual('/templates/1/items')

    describe "without items" , ->
      it "should exhibit attributes", ->
        t = new Actions.Models.Template({id: 1, title: 'Apple Pie'})
        expect(t.get('title')).toEqual('Apple Pie')
        expect(t.items.length).toEqual(0)
        expect(t.items.url).toEqual('/templates/1/items')
