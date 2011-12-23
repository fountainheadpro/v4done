describe "Template model", ->
  describe "when instantiated", ->
    it "should exhibit attributes", ->
      t = new Actions.Models.Template({
        title: 'Apple Pie',
        items: [{
          title: 'Ingredients',
        }, {
          title: 'Directions'
        }]
      })
      expect(t.get('title')).toEqual('Apple Pie')
      expect(t.get('items').length).toEqual(2)
      expect(t.get('items')[0].title).toEqual('Ingredients')
      expect(t.get('items')[1].title).toEqual('Directions')
