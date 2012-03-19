Feature: Navigating TODO list
  In order to navigate TODO list
  As a subscriber
  I want to navigate my list easily while maintaining focus in tasks

  Scenario: Top Level Actions Screen
    Given I opened the TODO list app
    Then I should see the goal written in bold font on the header
      And I should see the list of actions in format similar to email list screen on iPhone
      And I should see the arrow pointing right next on the right side of each action
      And I should see the action status (done/not done) on the left side of the of the action block.

  Scenario: Sub-actions Screen
    Given I opened the TODO list app
    Then I should see the goal written in bold font on the header
      And I should see the list of actions in format similar to email list screen on iPhone
      And I should see the arrow pointing right next on the right side of each action
      And I should see the action status (done/not done) on the left side of the of the action block.

