Then /the file "([^"]*)" should report an empty version/ do |file|
  partial_content = /version: ''$/

  check_file_content(file, partial_content, true)
end
