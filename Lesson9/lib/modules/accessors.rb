module Accessors

  def attr_accessors_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) do |value|
        old_value = instance_variable_get(var_name)
        instance_variable_set(var_name, value)
        @history ||= {}
        @history[name] ||= []
        @history[name] << old_value
      end
      define_method("#{name}_history") { @history[name].compact unless @history.nil? }
    end
  end

  def strong_attr_accessor(name, class_name)
    var_name = "@#{name}".to_sym
    define_method(name) { instance_variable_get(var_name) }
    define_method("#{name}=".to_sym) do |value|
      raise "Wrong  class! Valid - #{class_name}" unless value.instance_of?(class_name)
      instance_variable_set(var_name, value)
    end
  end
end
