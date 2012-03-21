Feature: Navigating TODO list
  In order to navigate TODO list
  As a subscriber
  I want to navigate my list easily while maintaining focus in tasks

  Background:
    Given I have project with few actions and subactions

  Scenario: Top Level Actions Screen
    When I open this project
    Then I should see the goal on the header
      And I should see the list of actions, each with status and link to subactions

  @not-implemented
  Scenario: Number of unfinished sub-actions
    When I open this project
    Then I should see the number of unfinished sub-actions for each action

  @not-implemented
  Scenario: I see an action with long description (longer than 3 lines of text of the screen)
    When I touch the description block
    Then I should see the full description
      And other actions pushed down to allow me to the whole description

  Scenario: Sub-actions Screen
    When I open a composite action from this project
    Then I should see the action title on the header
      And I should see the action description on top of the screen
      And I should see the list of subactions, each with status and link to subactions

  @not-implemented
  Scenario: Marking action complete
    When my action is complete
    And I click on action status
    Then I should see the cheange style to complete
      And I should see the action go to the bottom of the list

  @not-implemented
  Scenario: Returning to the app
    When I'm returning to the application
    Then I should see the last screen I left on


