require "rake/clean"

CLEAN.include ["enum_csv-*.gem", "rdoc", "coverage"]

desc "Build enum_csv gem"
task :package=>[:clean] do |p|
  sh %{#{FileUtils::RUBY} -S gem build enum_csv.gemspec}
end

### Specs

desc "Run specs"
task "spec" do
  sh "#{FileUtils::RUBY} #{'-w' if RUBY_VERSION >= '3'} spec/enum_csv_spec.rb"
end

task :default=>:spec

desc "Run specs with coverage"
task :spec_cov do
  ENV['COVERAGE'] = '1'
  sh "#{FileUtils::RUBY} spec/enum_csv_spec.rb"
end

### RDoc

require "rdoc/task"

RDoc::Task.new do |rdoc|
  rdoc.rdoc_dir = "rdoc"
  rdoc.options += ["--quiet", "--line-numbers", "--inline-source", '--title', 'EnumCSV: Create CSV from Enumerables', '--main', 'README.rdoc']

  begin
    gem 'hanna'
    rdoc.options += ['-f', 'hanna']
  rescue Gem::LoadError
  end

  rdoc.rdoc_files.add %w"README.rdoc CHANGELOG MIT-LICENSE lib/**/*.rb"
end
