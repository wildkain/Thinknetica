module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :validations

    def validate(name, type, *options)
      @validations ||= []
      @validations << { name: name, type: type, options: options }
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |validation|
        value = self.instance_variable_get("@#{validation[:name]}")
        send (validation[:type]).to_s, value, validation[:options]
      end
    end

    def valid?
      validate!
      true
    rescue
      false
    end

    private

    def presence(name, *_options)
      raise ArgumentError, "Empty '#{name}' argument" if name == ""
    end

    def type(name, type)
      raise ArgumentError, "Type #{type} does not match" unless name.instance_of?(type[0])
    end

    def formatt(name, formatt)
      raise ArgumentError, "#{name} not match #{formatt}" unless name =~ formatt[0]
    end
  end
end
