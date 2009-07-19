desc "Lists the most recent statuses posted of you and your friends."
command :list do |c|

  c.desc "Specifies the number of statuses to retrieve. May not be greater than 200."
  c.default_value 20
  c.flag :count

  c.action do |global_options,options,args|
  end
end

