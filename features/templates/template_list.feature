Feature: Template lists
  As a registered user of the website
  I want to to be able to view all my templats
  So I can manage them

    Background:
      Given I am logged in

    @template @javascript
    Scenario: View my templates
      Given I have few templates
      When I look at the list of templates
      Then I should see all my templates

    @template @javascript
    Scenario: I don't see templates of other users
      Given another user exists
        And he have few templates too
      When I look at the list of templates
      Then I should not see his templates