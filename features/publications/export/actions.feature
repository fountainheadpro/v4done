Feature: Subscribe to Achieve a Goal
  As a anonymous user
  I want subscribe to a follow action list
  So that I can accomplish the goal described in action list

  @not-implemented
  Scenario: Subscription via phone
    Given I found some interesting goal
    When I click "Accomplish" on this goal
      And enter my phone number in the opened dialog box
      And press "Send" button
    Then I should receive sms with link to todo-list

  Scenario: Subscription via e-mail
    Given I found some interesting goal
    When I provide my email address
    Then I should receive email with link to todo-list
