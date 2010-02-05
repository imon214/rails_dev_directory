As a Provider
I want to be able manage my account
So that I can make sure my profile is accurate and up-to-date

  Background:
    Given a service category "Stack"
      And a service category "Programming Languages"
      And the service category "Programming Languages" has proficiency
      And the following services:
      | category              | service |
      | Programming Languages | Ruby    |
      | Programming Languages | Python  |

  Scenario: Provider manages their account
    Given a provider "Kooky" belonging to "paul@dopo.com"
      And I am on the homepage
    When I log in as "paul@dopo.com" with password "testtest"
      And I follow "Profile" within "#provider-nav"
      And I follow "Edit Your Profile"
      Then I should see "View Your Profile"
    When I fill in "Street Address" with "Market Street"
      And I check "Ruby"
      And I choose "Programming Languages Ruby Intermediate"
      And I press "Save Services"
    Then I should see "Thanks for updating your profile"
      And I should not see "Stack"
      And I should see "Programming Languages"
      And I should see "Ruby"
      And I should see "Intermediate"
    When I follow "View Your Profile"
    Then I should not see "Python"
    When I follow "Edit Your Profile"
    Then the "Ruby" checkbox should be checked
      And the "Programming Languages Ruby Intermediate" checkbox should be checked
      And the "Python" checkbox should not be checked
      
