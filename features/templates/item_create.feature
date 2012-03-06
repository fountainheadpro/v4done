@template @javascript
Feature: Create Item
  As a registered user of the website
  I want to to be able to create an item in template
  So I can share my knowledge

    Background:
      Given I am logged in
        And I have the template with items and subitems


    Scenario: I create new item
      When I create new item in this template
      Then I should see this item

    @wip
    Scenario: Create new item with some positin
      When I create new item after first one
        And refresh page
      Then I should see this item as second