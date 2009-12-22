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
      |Worker user|
    And I am on the office hours page
    When I press "new office hour" 3 times
    And I fill in the following into the office hours index form for worker user:
      |row|day_of_week|client       |start_time(1i)|start_time(2i)|end_time(1i)|end_time(2i)|
      |1  |5          |Test Client 2|01            |00            |03          |30          |
      |2  |1          |Test Client 1|13            |30            |15          |00          |
      |3  |3          |Test Client 2|10            |30            |11          |00          |
    And I press "Update office hours"
    And I press "new office hour" 2 times
    And I fill in the following into the office hours index form for worker user:
      |row|day_of_week|client       |start_time(1i)|start_time(2i)|end_time(1i)|end_time(2i)|
      |4  |4          |Test Client 2|13            |30            |15          |00          |
      |5  |1          |Test Client 1|12            |30            |13          |30          |
    Then I should see the following office hours in order:
      |day_of_week|client       |start_time(1i)|start_time(2i)|end_time(1i)|end_time(2i)|
      |1          |Test Client 1|12            |30            |13          |30          |
      |1          |Test Client 1|13            |30            |15          |00          |
      |3          |Test Client 2|10            |30            |11          |00          |
      |4          |Test Client 2|13            |30            |15          |00          |
      |5          |Test Client 1|12            |30            |13          |30          |
  Scenario: Delete office_hour
    Given I am a signed in admin user called Matt
    And the following office_hour records:
      |client_id|user_id|day_of_week|start_time|end_time|
      |1        |1      |1          |1:00      |2:00    |
      |2        |2      |2          |2:00      |3:00    |
      |3        |3      |3          |3:00      |4:00    |
      |4        |4      |4          |4:00      |5:00    |
    When I go to the office hours page
    And I delete the 3rd office_hour
    Then I should see the following office_hours in order:
      |Client|User|Day of week|Start time|End time|
      |client_id 1|user_id 1|day_of_week 1|start_time 1|end_time 1|
      |client_id 2|user_id 2|day_of_week 2|start_time 2|end_time 2|
      |client_id 4|user_id 4|day_of_week 4|start_time 4|end_time 4|
