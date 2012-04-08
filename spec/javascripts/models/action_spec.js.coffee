describe "Action", ->
  describe ".isCompleted", ->
    it "returns true when action is completed", ->
      action = new ProjectApp.Models.Action({ _id: 1, completed: true})
      expect(action.isCompleted()).toBeTruthy()

    it "returns false when action is not completed", ->
      action = new ProjectApp.Models.Action({ _id: 1, completed: false})
      expect(action.isCompleted()).toBeFalsy()

    it "returns false when not unknown that action completed or not", ->
      action = new ProjectApp.Models.Action({ _id: 1, completed: null})
      expect(action.isCompleted()).toBeFalsy()