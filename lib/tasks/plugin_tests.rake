#  Run all core and plugins specs via
#  rake spec_all 
#
#  Run plugins specs via
#  rake spec_plugins
#
#  A plugin must register for tests via config variable 'plugins_to_test_paths'
#
#  e.g.
#  class Engine < ::Rails::Engine
#    initializer 'register_path_to_rspec' do |app|
#      app.config.plugins_to_test_paths << self.root
#    end
#  end
#

begin
  require "rspec/core/rake_task"

  desc "Run all core and plugin specs"
  RSpec::Core::RakeTask.new(:spec_all => :environment) do |t|
    pattern = []
    dirs = get_plugins_to_test
    dirs << File.join(Rails.root).to_s
    dirs.each do |dir|
      if File.directory?( dir )
        pattern << File.join( dir, 'spec', '**', '*_spec.rb' ).to_s
      end
    end
    t.fail_on_error = false
    t.pattern = pattern
  end

  desc "Run all plugin specs"
  RSpec::Core::RakeTask.new(:spec_plugins => :environment) do |t|
    pattern = []
    get_plugins_to_test.each do |dir|
      if File.directory?( dir )
        pattern << File.join( dir, 'spec', '**', '*_spec.rb' ).to_s
      end
    end
    t.fail_on_error = false
    t.pattern = pattern
  end
rescue LoadError
end

def get_plugins_to_test
  plugin_paths = []
  Rails.application.config.plugins_to_test_paths.each do |dir|
    if File.directory?( dir )
      plugin_paths << File.join(dir).to_s
    end
  end
  plugin_paths
end