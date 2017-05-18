class Module
  def attribute (arg, &block)
    name, default = arg.is_a?(Hash)? arg.first : arg
    value = "@" + name

    define_method (name) do
      unless instance_variable_get value
        instance_variable_set value, (block_given? ? instance_eval(&block) : default)
      end
      instance_variable_get value
    end
    define_method (name + "=") { |argument| instance_variable_set value, argument }
    define_method (name + "?") { instance_variable_get value }
  end
end