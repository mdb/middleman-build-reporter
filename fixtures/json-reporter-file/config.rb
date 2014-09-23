activate :build_reporter do |build|
  build.repo_root = '../../../'
  build.reporter_file_formats = ['json']
  build.version = '1.2.3'
end
