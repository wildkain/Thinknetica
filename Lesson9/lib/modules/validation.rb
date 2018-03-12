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
        send (validation[:type]).to_s, validation[:name], validation[:options]
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
      attr = self.instance_variable_get("@#{name}")
      raise ArgumentError, "Empty '#{name}' argument" if attr == ""
    end

    def type(name, type)
      attr = self.instance_variable_get("@#{name}")
      raise ArgumentError, "Type #{type} does not match" unless attr.instance_of?(type[0])
    end

    def formatt(name, formatt)
      raise ArgumentError, "#{name} not match #{formatt}" unless name =~ formatt
    end
  end
end