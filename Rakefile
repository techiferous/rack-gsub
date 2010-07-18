require 'rake'
require 'rake/testtask'
require 'rubygems'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test Rack::Gsub'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name          = "rack-gsub"
    s.version       = "0.0.0"
    s.add_dependency 'rack-plastic', '>= 0.0.3'
    s.author        = "Wyatt Greene"
    s.email         = "techiferous@gmail.com"
    s.summary       = "Rack middleware wrapper for gsub."
    s.description   = %Q{
      This is a Rack middleware wrapper for gsub. You can replace text on your
      web page without worrying about accidentally modifying the HTML tags
      themselves.
    }
    s.require_path  = "lib"
    s.files         = []
    s.files         << "README.rdoc"
    s.files         << "LICENSE"
    s.files         << "CHANGELOG"
    s.files         << "Rakefile"
    s.files         += Dir.glob("lib/**/*")
    s.files         += Dir.glob("test/**/*")
    s.homepage      = "http://github.com/techiferous/rack-gsub"
    s.requirements  << "none"
    s.has_rdoc      = false
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end
