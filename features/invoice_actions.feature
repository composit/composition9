Feature: Invoice Actions
  In order to manage invoices
  As a system user
  I want to set and view values

  Scenario Outline: View time to next invoice
    Given I have a client named Test
    Given Test has an invoice period of 2 weeks
    Given Test has an invoice dated <invoice_days_ago> days ago
    Given the following user records
      | login       | is_admin |
      | admin       | 1        |
      | client_user | 0        |
    Given client_user belongs to the client Test
    Given admin has an <tt_invoiced_or_uninvoiced> ticket_time dated <tt_days_ago> days ago
    Given I am logged in as client with password abc123
    When I go to invoices_path
    Then I should <action> 

    Examples:
      | invoice_days_ago | tt_invoiced_or_uninvoiced | tt_days_ago | action                                        |
      |                  | "uninvoiced"              | 20          | see "Your next invoice will be available on " |
