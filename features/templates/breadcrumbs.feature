@javascript
Feature: Breadcrumbs
  In order to know where I am
  As a registered user of the website
  I want to to be able to view breadcrumbs

    Background:
      Given I am logged in
        And I have the template with items and subitems

    Scenario: Breadcrumbs for a list of templates
      When I look at the list of templates
      Then I should see breadcrumbs: root element without separator

    Scenario: Breadcrumbs for a template
      When I look at this template
      Then I should see breadcrumbs: root element

    Scenario: Breadcrumbs for an item
      When I look at the item of this template
      Then I should see breadcrumbs: root element, title of the template

    @not-implemented
    Scenario: Breadcrumbs for a subitem
      When I look at some subitem of this template
      Then I should see breadcrumbs: root element, title of the template, title of the parent item
