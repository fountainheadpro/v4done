Feature: Navigating TODO list
  In order to navigate TODO list
  As a subscriber
  I want to navigate my list easily while maintaining focus in tasks

  @wip
  Scenario: Top Level Actions Screen
    Given I have project with few actions and subactions
    When I open this project
    Then I should see the title of project written in bold font on the header
      And I should see the list of actions in format similar to email list screen on iPhone
      And I should see the arrow pointing right next on the right side of each action
      And I should see the action status (done/not done) on the left side of the of the action block

  @not-implemented
  Scenario: Sub-actions Screen
    Given I have project with few actions and subactions
    When I open some action from this project
    Then I should see the title of project written in bold font on the header
      And I should see the list of subactions in format similar to email list screen on iPhone
      And I should see the arrow pointing right next on the right side of each subaction
      And I should see the subaction status (done/not done) on the left side of the of the subaction block.

