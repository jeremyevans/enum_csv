spec = Gem::Specification.new do |s|
  s.name = 'enum_csv'
  s.version = '1.0.0'
  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true
  s.extra_rdoc_files = ["README.rdoc", "CHANGELOG", "MIT-LICENSE"]
  s.rdoc_options += ["--quiet", "--line-numbers", "--inline-source", '--title', 'EnumCSV: Create CSV from Enumerables', '--main', 'README.rdoc']
  s.license = "MIT"
  s.summary = "Create CSV from Enumerables"
  s.author = "Jeremy Evans"
  s.email = "code@jeremyevans.net"
  s.homepage = "http://gihub.com/jeremyevans/enum_csv"
  s.files = %w(MIT-LICENSE CHANGELOG README.rdoc Rakefile) + Dir["{spec,lib}/**/*.rb"]
  s.description = <<END
EnumCSV exposes a single method, csv, for easily creating CSV
output/files from enumerable objects.
END
end
