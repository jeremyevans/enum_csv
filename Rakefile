require "rake/clean"

CLEAN.include ["enum_csv-*.gem", "rdoc", "coverage"]

desc "Build enum_csv gem"
task :package=>[:clean] do |p|
  sh %{#{FileUtils::RUBY} -S gem build enum_csv.gemspec}
end

### Specs

desc "Run specs"
task "spec" do
  sh "#{FileUtils::RUBY} #{'-w' if RUBY_VERSION >= '3'} #{'-W:strict_unused_block' if RUBY_VERSION >= '3.4'} spec/enum_csv_spec.rb"
end

task :default=>:spec

desc "Run specs with coverage"
task :spec_cov do
  ENV['COVERAGE'] = '1'
  sh "#{FileUtils::RUBY} spec/enum_csv_spec.rb"
end

### RDoc

desc "Generate rdoc"
task :rdoc do
  rdoc_dir = "rdoc"
  rdoc_opts = ["--line-numbers", "--inline-source", '--title', 'EnumCSV: Create CSV from Enumerables']

  begin
    gem 'hanna'
    rdoc_opts.concat(['-f', 'hanna'])
  rescue Gem::LoadError
  end

  rdoc_opts.concat(['--main', 'README.rdoc', "-o", rdoc_dir] +
    %w"README.rdoc CHANGELOG MIT-LICENSE" +
    Dir["lib/**/*.rb"]
  )

  FileUtils.rm_rf(rdoc_dir)

  require "rdoc"
  RDoc::RDoc.new.document(rdoc_opts)
end
