Feature: Manage users
  In order to [goal]
  [stakeholder]
  wants [behaviour]
  
  #TODO permissions
  #TODO add new user
  #TODO delete user
  #TODO edit user
  Scenario: Administering office_hour
    Given I am a signed in admin user called Matt
    And the following client records:
      |name         |
      |Test Client 1|
      |Test Client 2|
    And the following user records:
      |login      |
      |Worker user|
    And I am on the edit page for Worker user
    When I fill in "user_number_of_office_hours_to_add" with "3"
    And I press "Update office hours"
    And I fill the following into the office hours index form:
      |row|day_of_week|client_id    |start_time_4i|start_time_5i|end_time_4i|end_time_5i|
      |0  |Fri        |Test Client 2|01           |00           |03         |30         |
      |1  |Mon        |Test Client 1|13           |30           |15         |00         |
      |2  |Wed        |Test Client 2|10           |30           |11         |00         |
    And I press "Update office hours"
    And I fill in "user_number_of_office_hours_to_add" with "2"
    And I press "Update office hours"
    And I fill the following into the office hours index form:
      |row|day_of_week|client_id    |start_time_4i|start_time_5i|end_time_4i|end_time_5i|
      |2  |Fri        |Test Client 1|01           |00           |02         |30         |
      |3  |Thu        |Test Client 2|13           |30           |15         |00         |
      |4  |Mon        |Test Client 1|12           |30           |13         |30         |
    And I press "Update office hours"
    And I should see the following office hours in order:
      |row|day_of_week|client_id    |start_time_4i|start_time_5i|end_time_4i|end_time_5i|
      |0  |Mon        |Test Client 1|12           |30           |13         |30         |
      |1  |Mon        |Test Client 1|13           |30           |15         |00         |
      |2  |Wed        |Test Client 2|10           |30           |11         |00         |
      |3  |Thu        |Test Client 2|13           |30           |15         |00         |
      |4  |Fri        |Test Client 1|01           |00           |02         |30         |

#TODO deleting office hours
#  Scenario: Delete office_hour
#    Given I am a signed in admin user called Matt
#    And the following user records:
#      |login      |
#      |Worker user|
#    And the following office_hour records for Worker user:
#      |user_id|day_of_week|start_time|end_time|
#      |1      |Mon        |1:00      |2:00    |
#      |2      |Tue        |2:00      |3:00    |
#      |3      |Wed        |3:00      |4:00    |
#      |4      |Thu        |4:00      |5:00    |
#    When I go to the office hours page for Worker user
#    Then show me the page
#    And I delete the 3rd office_hour
#    Then I should see the following office_hours in order:
#      |Client|User|Day of week|Start time|End time|
#      |client_id 1|user_id 1|day_of_week 1|start_time 1|end_time 1|
#      |client_id 2|user_id 2|day_of_week 2|start_time 2|end_time 2|
#      |client_id 4|user_id 4|day_of_week 4|start_time 4|end_time 4|
