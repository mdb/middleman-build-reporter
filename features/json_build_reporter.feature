Feature: JSON build reporter file

  Scenario: build.json should report a branch
    Given a successfully built app at "json-reporter-file"
    When I cd to "build"
    Then the JSON file "build.json" should report the current branch

  Scenario: build.yaml should report a revision
    Given a successfully built app at "json-reporter-file"
    When I cd to "build"
    Then the JSON file "build.json" should report the current git revision

  Scenario: build.json should report a build time
    Given a successfully built app at "json-reporter-file"
    When I cd to "build"
    Then the JSON file "build.json" should report the build time

  Scenario: build.json should report a version
    Given a successfully built app at "json-reporter-file"
    When I cd to "build"
    Then the JSON file "build.json" should report version "1.2.3"
