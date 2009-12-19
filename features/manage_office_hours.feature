Feature: Manage office_hours
  In order to keep track of time between clients
  a worker
  wants to manage their office hours
  
  Scenario: Register new office_hour
    Given I am a signed in admin user called Matt
      And the following client records:
        |name         |
        |Test Client 1|
        |Test Client 2|
      And the following user records:
        |login      |
        |Client user|
      And I am on the new office_hour page
    When I fill in the following:
      |Client     |Test Client 1|
      |User       |Client user  |
      |Day of week|1            |
      |Start time |10:00        |
      |End time   |11:00        |
      And I press "Create"
    Then I should see "Test Client 1"
      And I should see "Client user"
      And I should see "1"
      And I should see "10:00"
      And I should see "11:00"

  Scenario: Delete office_hour
    Given the following office_hours:
      |client_id|user_id|day_of_week|start_time|end_time|
      |client_id 1|user_id 1|day_of_week 1|start_time 1|end_time 1|
      |client_id 2|user_id 2|day_of_week 2|start_time 2|end_time 2|
      |client_id 3|user_id 3|day_of_week 3|start_time 3|end_time 3|
      |client_id 4|user_id 4|day_of_week 4|start_time 4|end_time 4|
    When I delete the 3rd office_hour
    Then I should see the following office_hours:
      |Client|User|Day of week|Start time|End time|
      |client_id 1|user_id 1|day_of_week 1|start_time 1|end_time 1|
      |client_id 2|user_id 2|day_of_week 2|start_time 2|end_time 2|
      |client_id 4|user_id 4|day_of_week 4|start_time 4|end_time 4|
