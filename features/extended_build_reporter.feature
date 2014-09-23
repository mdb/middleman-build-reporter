Feature: Extended build reporter details

  Scenario: build.yaml should report the custom supplemental details
    Given a successfully built app at "extended-build-reporter"
    When I cd to "build"
    Then the file "build.yaml" should contain "some_key: some value"
    And the file "build.yaml" should contain "another_key: another value"
