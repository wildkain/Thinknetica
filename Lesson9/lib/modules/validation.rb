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
        send validation[:type].to_s, value, validation[:options]
      end
    end

    def valid?
      validate!
      true
    rescue
      false
    end

    private

    def presence(value, *_options)
      raise ArgumentError, "Empty '#{value}' argument" if value.empty? || value.nil?
    end

    def type(name, type)
      raise ArgumentError, "Type #{type} does not match" unless name.instance_of?(type[0])
    end

    def formatt(value, formatt)
      raise ArgumentError, "#{value} not match #{formatt}" unless value =~ formatt[0]
    end
  end
end
