$:.unshift File.dirname(__FILE__)
%w[rubygems ostruct yaml highline/import ftools gli twitter].each { |f| require f }
RUBY_PLATFORM = PLATFORM unless defined? RUBY_PLATFORM # Ruby 1.8 compatibility
 
require 'twitter_app'
include GLI
Dir['lib/commands/*.rb'].each {|file| load file}

CONFIG_FILE = "~/.twitter/glitter.yml"

desc 'Show version'
switch :version

pre do |globals,command,options,args|
  @config = TwitterConfig.new(CONFIG_FILE)

  if command.nil?
    if globals.version
      puts "glitter version #{File.read 'VERSION'}"
    else
      commands[:help].execute(globals,options,args)
    end
    false
  elsif command && command.name == :help
    true # always help
  elsif @config.atoken.nil?
    if command && command.name == :init
      true
    else
      puts "Sorry, but you need to initialize first. Try this:"
      puts "\n"
      puts "    $ glitter init"
      puts "\n"
      false
    end
  else
    @twitter = TwitterApp.new(@config)
    true # already init
  end
end

post do |globals,command,options,args|
end

on_error do |ex|
  puts ex.message
  puts ex.backtrace.join("\n")
  true
end

GLI.run(ARGV) if __FILE__ == $0

