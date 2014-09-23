Then /the JSON file "([^"]*)" should report the current branch/ do |file|
  prep_for_fs_check do
    json = JSON.parse(File.open(file).read)

    expect(json['branch']).to eq "#{Git.open(gem_root_relative_to_features).current_branch}"
  end
end

Then /the JSON file "([^"]*)" should report the current git revision/ do |file|
  prep_for_fs_check do
    json = JSON.parse(File.open(file).read)

    expect(json['revision']).to eq "#{Git.open(gem_root_relative_to_features).log.first.to_s}"
  end
end

Then /the JSON file "([^"]*)" should report the build time/ do |file|
  prep_for_fs_check do
    json = JSON.parse(File.open(file).read)

    expect(json['build_time']).to include "#{Time.now.strftime('%Y-%m-%d %H:%M')}"
  end
end

Then /the JSON file "([^"]*)" should report version "([^"]*)"/ do |file, version|
  prep_for_fs_check do
    json = JSON.parse(File.open(file).read)

    expect(json['version']).to eq version
  end
end
