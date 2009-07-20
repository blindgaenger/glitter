desc "Updates your current status"
arg_name "status"
command :post do |c|
  c.action do |global_options,options,args|
    message = args.join(' ').strip
    @twitter.update(message)
  end
end
