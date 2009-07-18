Feature: Invoice Actions
  In order to manage invoices
  As a system user
  I want to set and view values

  Scenario Outline: View time to next invoice
    Given the following 
    Given the following user records
      | login       | is_admin |
      | admin       | 1        |
      | client_user | 0        |
    Given I am logged in as client with password abc123
    When I go to invoices_path
    Then I should see "Next invoice on"
