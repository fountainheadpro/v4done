describe "Item collection", ->
  describe "filtered byParentId", ->
    beforeEach ->
      @item1 = new Actions.Models.Item({ _id: 1, title: 'foo'})
      @item2 = new Actions.Models.Item({ _id: 2, title: 'bar', parent_id: 1})
      @item3 = new Actions.Models.Item({ _id: 3, title: 'baz', parent_id: 1})
      @item4 = new Actions.Models.Item({ _id: 4, title: 'qux', parent_id: 3})

    it "returns only items with specific parent_id", ->
      items = new Actions.Collections.ItemsCollection([@item1, @item2, @item3, @item4])
      expect(items.byParentId(null).length).toEqual(1)
      expect(items.byParentId(null).at(0)).toEqual(@item1)
      expect(items.byParentId(1).length).toEqual(2)
      expect(items.byParentId(1).at(0)).toEqual(@item2)
      expect(items.byParentId(1).at(1)).toEqual(@item3)
      expect(items.byParentId(3).length).toEqual(1)
      expect(items.byParentId(3).at(0)).toEqual(@item4)
      expect(items.byParentId(4).length).toEqual(0)

  describe "filtered byPreviousId", ->
    beforeEach ->
      @item1 = new Actions.Models.Item({ _id: 1, title: 'foo'})
      @item2 = new Actions.Models.Item({ _id: 2, title: 'bar', previous_id: 1})
      @item3 = new Actions.Models.Item({ _id: 3, title: 'baz'})
      @item4 = new Actions.Models.Item({ _id: 4, title: 'qux', previous_id: 3})

    it "returns only items with specific previous_id", ->
      items = new Actions.Collections.ItemsCollection([@item1, @item2, @item3, @item4])
      expect(items.byPreviousId(null).length).toEqual(2)
      expect(items.byPreviousId(null).at(0)).toEqual(@item1)
      expect(items.byPreviousId(null).at(1)).toEqual(@item3)
      expect(items.byPreviousId(1).length).toEqual(1)
      expect(items.byPreviousId(1).at(0)).toEqual(@item2)
      expect(items.byPreviousId(3).length).toEqual(1)
      expect(items.byPreviousId(3).at(0)).toEqual(@item4)
      expect(items.byPreviousId(4).length).toEqual(0)

  describe ".sortByPosition", ->
    describe "normal collection", ->
      it "should returns items in correct order", ->
        @item1 = new Actions.Models.Item({ _id: 1, title: 'first'})
        @item2 = new Actions.Models.Item({ _id: 2, title: 'second', previous_id: 1})
        @item3 = new Actions.Models.Item({ _id: 3, title: 'third', previous_id: 2})
        @items = new Actions.Collections.ItemsCollection([@item3, @item2, @item1])

        sortedItems = @items.sortByPosition()
        expect(sortedItems.at(0)).toEqual(@item1)
        expect(sortedItems.at(1)).toEqual(@item2)
        expect(sortedItems.at(2)).toEqual(@item3)

    describe "collection with branches", ->
      it "should returns items in correct order", ->
        @item1 = new Actions.Models.Item({ _id: 1, title: 'first'})
        @item2 = new Actions.Models.Item({ _id: 2, title: 'second', previous_id: 1})
        @item3 = new Actions.Models.Item({ _id: 3, title: 'third', previous_id: 1})
        @items = new Actions.Collections.ItemsCollection([@item3, @item2, @item1])

        sortedItems = @items.sortByPosition()
        expect(sortedItems.at(0)).toEqual(@item1)
        expect(sortedItems.at(1)).toEqual(@item3)
        expect(sortedItems.at(2)).toEqual(@item2)

describe "An Item", ->
  beforeEach ->
    @item = new Actions.Models.Item({ _id: 1, title: 'foo'})

  it "should be a root", ->
    expect(@item.isRoot()).toBeTruthy()

  describe "when adding a child", ->
    beforeEach ->
      @child = new Actions.Models.Item({ _id: 2, title: 'bar', parent_id: @item.id})

    describe "the child", ->
      it "should not be the root", ->
        expect(@child.isRoot()).toBeFalsy()

