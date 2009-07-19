desc "Lists the most recent statuses posted of you and your friends."
command :list do |c|

  c.desc "Specifies the number of statuses to retrieve. May not be greater than 200."
  c.default_value 20
  c.flag :count

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
  
    statuses = @twitter.friends_timeline({:count => options[:count]})
    statuses.each {|status|
      say bold(status.user.screen_name) + ' ' + color(status.created_at, :yellow)
      puts
      say indent(status.text)
      puts
    }
  end
end

