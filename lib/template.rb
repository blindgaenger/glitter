class Object
  module InstanceExecHelper; end
  include InstanceExecHelper
  def instance_exec(*args, &block)
    begin
      old_critical, Thread.critical = Thread.critical, true
      n = 0
      n += 1 while respond_to?(mname="__instance_exec#{n}")
      InstanceExecHelper.module_eval{ define_method(mname, &block) }
    ensure
      Thread.critical = old_critical
    end
    begin
      ret = send(mname, *args)
    ensure
      InstanceExecHelper.module_eval{ remove_method(mname) } rescue nil
    end
    ret
  end
end


class Template
  def initialize(globals, &block)
    @color = !globals['no-color']
    @block = block
  end

  def print(args)
    say instance_exec(args, &@block)
  end
  
  def print_each(list)
    list.each {|item|
      print item
    }
  end

  def bold(text)
    return text unless @color
    "<%= color('#{text}', BOLD) %>"
  end

  def color(text, color)
    return text unless @color
    "<%= color('#{text}', :#{color.to_s}) %>"
  end

  def indent(text, length=4)
    ' '*length + wrap(text, length, 80)
  end
end
