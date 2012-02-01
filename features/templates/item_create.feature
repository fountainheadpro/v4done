Feature: Create Item
  As a registered user of the website
  I want to to be able to create an item in template
  So I can share my knowledge

    @template @javascript
    Scenario: I create new item
      Given I am logged in
        And I have the template with items and subitems
      When I create new item in this template
      Then I should see this item