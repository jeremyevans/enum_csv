require "rake"
require "rake/clean"
require 'rake/testtask'

CLEAN.include ["enum_csv-*.gem", "rdoc", "coverage"]

desc "Build enum_csv gem"
task :package=>[:clean] do |p|
  sh %{#{FileUtils::RUBY} -S gem build enum_csv.gemspec}
end

### Specs

desc "Run specs"
Rake::TestTask.new do |t|
  t.libs.push "lib"
  t.test_files = FileList['spec/*_spec.rb']
  t.verbose = true
end

task :default=>:test
### RDoc

RDOC_DEFAULT_OPTS = ["--quiet", "--line-numbers", "--inline-source", '--title', 'EnumCSV: Create CSV from Enumerables']

begin
  gem 'hanna-nouveau'
  RDOC_DEFAULT_OPTS.concat(['-f', 'hanna'])
rescue Gem::LoadError
end

rdoc_task_class = begin
  require "rdoc/task"
  RDoc::Task
rescue LoadError
  require "rake/rdoctask"
  Rake::RDocTask
end

RDOC_OPTS = RDOC_DEFAULT_OPTS + ['--main', 'README.rdoc']

rdoc_task_class.new do |rdoc|
  rdoc.rdoc_dir = "rdoc"
  rdoc.options += RDOC_OPTS
  rdoc.rdoc_files.add %w"README.rdoc CHANGELOG MIT-LICENSE lib/**/*.rb"
end

