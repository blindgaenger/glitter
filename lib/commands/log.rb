desc "Lists the most recent statuses posted of you and your friends."
command :log do |c|

  c.desc "Specifies the number of statuses to retrieve. May not be greater than 200."
  c.default_value 20
  c.flag :n, :'max-count'

  c.desc "Show colored diff."
  c.switch :color
  
  c.desc "Turn off colored diff."
  c.switch :"no-color"

  c.action do |globals, options, args|
    template = Template.new(options) do |status|
    <<-EOL
#{color "commit #{status.id}", :yellow}
Author: #{status.user.screen_name} <#{status.user.name}>
Date:   #{status.created_at}

#{indent(status.text)}

EOL
    end

    statuses = @twitter.friends_timeline({:count => options.n})
    template.print_each statuses
  end
end

