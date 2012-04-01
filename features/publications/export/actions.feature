Feature: Subscribe to Achieve a Goal
  As a anonymous user
  I want subscribe to a follow action list
  So that I can accomplish the goal described in action list

  Background:
    Given I found some interesting goal

  Scenario: Subscription via sms
    When I provide my phone number
    Then I should receive sms with link to todo-list

  Scenario: Subscription via e-mail
    When I provide my email address
    Then I should receive email with link to todo-list
