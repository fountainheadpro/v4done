Feature: Navigating TODO list
  In order to navigate TODO list
  As a subscriber
  I want to navigate my list easily while maintaining focus in tasks

  Background:
    Given I have project with few actions and subactions

  @wip
  Scenario: Top Level Actions Screen
    When I open this project
    Then I should see the title of project on the header
      And I should see the list of actions, each with status and link to subactions

  @not-implemented
  Scenario: Sub-actions Screen
    When I open some action from this project
    Then I should see the title of project on the header
      And I should see the list of subactions, each with status and link to subactions

