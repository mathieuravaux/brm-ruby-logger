require 'rubygems'
require 'rake'

begin
  require 'metric_fu' rescue LoadError
  MetricFu::Configuration.run do |config|
    config.metrics = [:flog, :flay, :reek, :saikuro]
    config.graphs = [:flog, :flay, :reek]
    config.graph_engine = :gchart
  end
rescue LoadError
  puts "Metric_fu (or a dependency) not available. Install it with: gem install metric_fu"
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "brm-ruby-logger"
    gem.summary = "Ruby event logger for the BRM real-time analytics and BI solution"
    gem.description = ""
    gem.email = "mathieu.ravaux@gmail.com"
    gem.homepage = "http://github.com/mathieuravaux/brm-ruby-logger"
    gem.authors = ["mathieuravaux"]
    gem.add_development_dependency "rspec", ">= 1.2.9"
    gem.add_dependency "bunny"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "brm-ruby-logger #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
