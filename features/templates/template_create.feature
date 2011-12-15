Feature: Create Template
  As a registered user of the website
  I want to to be able to create a template
  So I can share my knowledge

    @template @javascript
    Scenario: I create new template
      Given I am logged in
      When I create new template
      Then I should see this template