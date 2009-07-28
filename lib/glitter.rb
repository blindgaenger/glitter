$:.unshift File.dirname(__FILE__)
%w[rubygems ostruct yaml highline/import ftools gli twitter].each { |f| require f }
RUBY_PLATFORM = PLATFORM unless defined? RUBY_PLATFORM # Ruby 1.8 compatibility
 
require 'twitter_app'
include GLI
Dir['lib/commands/*.rb'].each {|file| load file}

CONFIG_FILE = "~/.twitter/glitter.yml"

pre do |global_options,command,options,args|
  @config = TwitterConfig.new(CONFIG_FILE)

  if command.nil?
    commands[:help].execute(global_options,options,args)
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

post do |global_options,command,options,args|
end

on_error do |ex|
  puts ex.message
  puts ex.backtrace.join("\n")
  true
end

GLI.run(ARGV) if __FILE__ == $0

