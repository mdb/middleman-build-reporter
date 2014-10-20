Feature: Build reporter fingerprint helper

  Scenario: the build reporter fingerprint should be written to the template
    Given a successfully built app at "build-reporter-fingerprint"
    When I cd to "build"
    Then the file "index.html" should report the build fingerprint
