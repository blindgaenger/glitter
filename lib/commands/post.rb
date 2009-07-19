desc "Updates your current status"
arg_name "status"
command :post do |c|
  c.action do |global_options,options,args|

    p args.join(' ').strip

  end
end
