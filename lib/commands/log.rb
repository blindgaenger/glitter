desc "Lists the most recent statuses posted of you and your friends."
command :log do |c|

  c.desc "Specifies the number of statuses to retrieve. May not be greater than 200."
  c.default_value 20
  c.flag :"max-count"

  c.action do |globals, options, args|
    def bold(text)
      "<%= color('#{text}', BOLD) %>"
    end

    def color(text, color)
      "<%= color('#{text}', :#{color.to_s}) %>"
    end
  
    def indent(text, length=4)
      ' '*length + wrap(text, length, 80)
    end

    statuses = @twitter.friends_timeline({:count => options['max-count']})
    statuses.each {|status|
      say <<-EOL
#{color status.id, :yellow}
Author: #{status.user.screen_name} <#{status.user.name}>
Date:   #{status.created_at}

#{indent(status.text)}

    EOL
    }

  end
end

