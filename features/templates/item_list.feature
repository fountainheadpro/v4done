Feature: Item lists
  As a registered user of the website
  I want to to be able to view template
  So I can manage items

    Background:
      Given I am logged in

    @template @item @javascript
    Scenario: View template
      Given I have the template with items and subitems
      When I look at this template
      Then I should see that items
