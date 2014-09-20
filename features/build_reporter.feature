Feature: Build reporter

  Scenario: build should have a branch
    Given a successfully built app at "basic-app"
    When I cd to "build"
    Then the file "build" should contain "branch:"
