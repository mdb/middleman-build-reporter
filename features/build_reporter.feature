Feature: Build reporter

  Scenario: build should report a branch
    Given a successfully built app at "basic-app"
    When I cd to "build"
    Then the file "build" should report the current branch

  Scenario: build should report a revision
    Given a successfully built app at "basic-app"
    When I cd to "build"
    Then the file "build" should report the current git revision"

  Scenario: build should report a build time
    Given a successfully built app at "basic-app"
    When I cd to "build"
    Then the file "build" should report the build time"

  Scenario: build should report a version
    Given a successfully built app at "basic-app"
    When I cd to "build"
    Then the file "build" should contain "version: 1.2.3"
