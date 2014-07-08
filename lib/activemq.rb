require 'activemq/version'
require 'ActiveMQ.so'

module ActiveMQ
  class Message
    def properties
      @property_proxy ||= PropertyProxy.new(self)
    end

    def properties=(hash)
      hash.each do |key, value|
        properties[key] = value
      end
    end
  end

  private

  class PropertyProxy
    attr_reader :message

    def initialize(message)
      @message = message
    end

    def type_of(name)
      message.get_property_value_type(name)
    end

    def [](name)
      name = name.to_s if name.is_a?(Symbol)
      case type_of(name)
        when :integer then message.get_int_property(name)
        when :boolean then message.get_boolean_property(name)
        when :double then message.get_double_property(name)
        when :float then message.get_float_property(name)
        when :long then message.get_long_property(name)
        when :short then message.get_short_property(name)
        else message.get_string_property(name)
      end
    end

    def []=(name, value)
      name = name.to_s if name.is_a?(Symbol)
      case value
        when Fixnum then message.set_int_property(name, value)
        when Float then message.set_double_property(name, value)
        when String then message.set_string_property(name, value)
        when TrueClass, FalseClass then message.set_boolean_property(name, value)
        else raise "Unsupported property type: #{value.class}"
      end
    end
  end
end
