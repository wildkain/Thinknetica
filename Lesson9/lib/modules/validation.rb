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
      @validations.inspect
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |validation|
        send (validation[:type]).to_s, validation[:name], validation[:options]
      end
      true
    end

    def valid?
      validate!
    rescue
      false
    end

    private

    def presence(name, *_options)
      raise ArgumentError, "#{name} empty" if send(name.to_s).to_s.empty?
    end

    def type(name, type)
      raise ArgumentError, "Type #{name} does not match" unless send(name.to_s).is_a?(type)
    end

    def formatt(name, formatt)
      raise ArgumentError, "#{name} not match #{formatt}" unless name =~ formatt
    end
  end
end