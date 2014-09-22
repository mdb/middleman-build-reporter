Feature: No explicit version declared in the config

  Scenario: build should report an empty version number
    Given a successfully built app at "no-version"
    When I cd to "build"
    Then the file "build.yaml" should report an empty version
