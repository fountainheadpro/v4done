Feature: Template lists
  In order to manage my templates
  A user
  Should be able to view my templates

    @javascript
    Scenario: View my templates
      Given I am logged in
      Given I have few templates
      When I look at the list of templates
      Then I should see all my templates

    @javascript
    Scenario: I don't see templates of other users
      Given I am logged in
      Given another user exists
        And he have few templates too
      When I look at the list of templates
      Then I should not see his templates