Feature: Invoice Actions
  In order to manage invoices
  As a system user
  I want to set and view values

  Scenario Outline: View time to next invoice
#    Given there is a client named Test
#    And Client Test has an invoice period of 2 weeks
#    And Client Test has an invoice dated <invoice_days_ago> days ago
#    And the following user records
#      | login       | is_admin |
#      | admin       | 1        |
#      | client_user | 0        |
#    And client_user belongs to the client Test
#    And admin has an <tt_invoiced_or_uninvoiced> ticket_time dated <tt_days_ago> days ago
#    And I am logged in as client with password abc123
#    When I go to invoices_path
#    Then I should <action> 
#
#    Examples:
#      | invoice_days_ago | tt_invoiced_or_uninvoiced | tt_days_ago | action                                        |
#      | 100              | "uninvoiced"              | 20          | see "Your next invoice will be available on " |
