Then /the file "([^"]*)" should report the current branch/ do |file|
  partial_content = "branch: #{Git.open('.').current_branch}"

  check_file_content(file, partial_content, true)
end

Then /the file "([^"]*)" should report the current git revision/ do |file|
  partial_content = "revision: #{Git.open('.').log.first.to_s}"

  check_file_content(file, partial_content, true)
end

Then /the file "([^"]*)" should report the build time/ do |file|
  partial_content = "build_time: #{Time.now.strftime('%Y-%m-%d %H:%M')}"

  check_file_content(file, partial_content, true)
end
