Feature: Item lists
  As a registered user of the website
  I want to to be able to view template
  So I can manage items

    Background:
      Given I am logged in

    @template @item @javascript @wip
    Scenario: View template
      Given I have template with few items
      When I look at the this template
      Then I should see that items
