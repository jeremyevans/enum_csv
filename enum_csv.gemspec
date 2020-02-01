spec = Gem::Specification.new do |s|
  s.name = 'enum_csv'
  s.version = '1.1.1'
  s.platform = Gem::Platform::RUBY
  s.extra_rdoc_files = ["README.rdoc", "CHANGELOG", "MIT-LICENSE"]
  s.rdoc_options += ["--quiet", "--line-numbers", "--inline-source", '--title', 'EnumCSV: Create CSV from Enumerables', '--main', 'README.rdoc']
  s.license = "MIT"
  s.summary = "Create CSV from Enumerables"
  s.author = "Jeremy Evans"
  s.email = "code@jeremyevans.net"
  s.homepage = "http://github.com/jeremyevans/enum_csv"
  s.files = %w(MIT-LICENSE CHANGELOG README.rdoc) + Dir["lib/**/*.rb"]
  s.metadata = {
    'bug_tracker_uri'   => 'https://github.com/jeremyevans/enum_csv/issues',
    'changelog_uri'     => 'https://github.com/jeremyevans/enum_csv/blob/master/CHANGELOG',
    'source_code_uri'   => 'https://github.com/jeremyevans/enum_csv',
  }
  s.description = <<END
EnumCSV exposes a single method, csv, for easily creating CSV
output/files from enumerable objects.
END
  s.add_development_dependency "minitest"
  s.add_development_dependency "minitest-global_expectations"
end
