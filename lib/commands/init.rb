desc "Registers glitter with your twitter account"
command [:init] do |c|

  c.action do |globals, options, args|
    #TODO: check for global --force option, not a git parameter but useful
    if @config.atoken
      puts "You already initialized glitter. Find out what else you can do:"
      puts "\n"
      puts "    $ glitter help"
      puts "\n"
    else
      authorized = TwitterApp.authorize(@config) {|url, counter|
        if counter == 0
          say "Open this URL in your browser and allow glitter access:"
          say "\n"
          say "    #{url}"
          say "\n"
        else
          say "Nope, can't access twitter. Please try the same URL again!"
        end
        
        ask "And now enter the PIN twitter gave to you:" do |q|
          # need to use readline, otherwise "The input stream is exhausted."
          q.readline = true
        end
      }
      
      if authorized
        say "Great, you can start tweeting!"
      else
        say "Hm, without authorization this tool is useless."
      end
    end
  end

end
