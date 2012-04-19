require "contractual/version"

module Contractual
  module Interface
    class MethodNotImplementedError < NoMethodError; end

    def self.included(klass)
      klass.send(:include, Interface::Methods)
      klass.send(:extend,  Interface::Methods)
      klass.send(:extend,  Interface::ClassMethods)
    end

    module Methods
      def does_not_implement_method(klass, method_name = nil)
        if method_name.nil?
          caller.first.match(/in \`(.+)\'/)
          method_name = $1
        end

        klass_name = klass.class.name
        interface_name = self.name

        raise MethodNotImplementedError.new("#{klass.class.name} needs to implement '#{method_name}' for interface #{self.name}!")
      end
    end

    module ClassMethods
      def must_implement(method_name, *args)
        this = self
        self.class_eval do
          define_method(method_name) do |*args|
            this.does_not_implement_method(self, method_name)
          end
        end
      end
      
      # helper alias
      def must(method_name, *args); must_implement(method_name, args); end
    end
  end
end