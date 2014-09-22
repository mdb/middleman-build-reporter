Feature: Custom build reporter file name declared in config.rb

  Scenario: the build report should be written to the custom file name
    Given a successfully built app at "custom-reporter-file-name"
    When I cd to "build"
    Then a file named "custom" should exist
