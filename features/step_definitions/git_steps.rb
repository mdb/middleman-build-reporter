Then /the file "([^"]*)" should report the current branch/ do |file|
  branch = Git.open('.').current_branch

  prep_for_fs_check do
    expect(YAML.load(File.read(file))['branch']).to eq branch
  end
end

Then /the file "([^"]*)" should report the current git revision/ do |file|
  partial_content = "revision: #{Git.open('.').log.first.to_s}"

  check_file_content(file, partial_content, true)
end

Then /the file "([^"]*)" should report the build time/ do |file|
  partial_content = "build_time: '#{Time.now.strftime('%Y-%m-%d %H:%M')}"

  check_file_content(file, partial_content, true)
end
