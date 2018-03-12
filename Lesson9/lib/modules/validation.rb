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
        true
      end
    end

    def valid?
      validate!
    rescue
      false
    end

    private

    def presence(name, *_options)
      raise ArgumentError, "Empty '#{name}' argument" if self.send(name.to_sym) == ""
    end

    def type(name, type)
      raise ArgumentError, "Type #{name} does not match" unless send(name.to_s).is_a?(type)
    end

    def formatt(name, formatt)
      raise ArgumentError, "#{name} not match #{formatt}" unless name =~ formatt
    end
  end
end