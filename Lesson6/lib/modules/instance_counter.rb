module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :instances

    def counter_up
      @instances ||= 0
      @instances +=1
    end

  end

  module InstanceMethods

    private

    def register_instance
      self.class.send :counter_up
    end

  end

end
