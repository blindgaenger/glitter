desc "Commit your current status"
command :commit do |c|

  c.desc "The text of your status update. Statuses over 140 characters will be forceably truncated."
  c.flag :message, :m

  c.action do |globals, options, args|
    unless options.message
      say "Aborting commit due to empty commit message."
    else
      @twitter.update(options.message)
    end
  end

end
