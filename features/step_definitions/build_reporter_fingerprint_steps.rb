Then /the file "([^"]*)" should report the build fingerprint/ do |file|
  prep_for_fs_check do
    html = File.open(file).read

    expect(html.include?("<!--\nFINGERPRINT:\n---\nbranch:")).to eq true
  end
end

