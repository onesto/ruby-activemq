# -*- encoding: utf-8 -*-
require 'spec_helper'

describe ActiveMQ::Message do
  let(:subject) do
    session = ActiveMQ::ConnectionFactory.new(BROKER_URL_TEST).create_connection.create_session
    session.create_text_message('test')
  end

  describe "constants" do
    it "should have an integer as DEFAULT_DELIVERY_MODE" do
      ActiveMQ::Message::DEFAULT_DELIVERY_MODE.should be_instance_of(::Fixnum)
    end

    it "should have an integer as DEFAULT_MSG_PRIORITY" do
      ActiveMQ::Message::DEFAULT_MSG_PRIORITY.should be_instance_of(::Fixnum)
    end

    it "should have an integer as DEFAULT_TIME_TO_LIVE" do
      ActiveMQ::Message::DEFAULT_TIME_TO_LIVE.should be_instance_of(::Fixnum)
    end
  end

  describe "properties" do
    it "should look up with string keys" do
      subject.set_string_property('a', '1')
      subject.properties['a'].should == '1'
    end

    it "should do a look up with symbol keys" do
      subject.set_string_property('a', '1')
      subject.properties[:a].should == '1'
    end

    it "should work with numbers" do
      subject.properties[:a] = 1
      subject.properties[:a].should == 1
    end

    it "should work with booleans" do
      subject.properties[:a] = true
      subject.properties[:a].should == true
    end

    it "should work with floats" do
      subject.properties[:a] = 1.2
      subject.properties[:a].should be_within(0.01).of(1.2)
    end

    it "should work with strings" do
      subject.properties[:a] = '1'
      subject.properties[:a].should == '1'
    end
  end

  describe "property_names" do
    it "should be initially empty" do
      subject.property_names.should be_empty
    end

    it "should return the names of the properties that were set" do
      subject.set_string_property('a', '1')
      subject.set_int_property('b', 2)
      subject.property_names.should == ['a', 'b']
    end
  end

  describe "property_exists?" do
    it "should return false if a property was not set" do
      subject.property_exists?('a').should == false
    end

    it "should return true when a property was set" do
      subject.set_string_property('a', '1')
      subject.property_exists?('a').should == true
    end
  end

  describe "get_property_value_type" do
    it "should return :integer when an integer was set" do
      subject.set_int_property('a', 1)
      subject.get_property_value_type('a').should == :integer
    end

    it "should return :boolean when a boolean was set" do
      subject.set_boolean_property('a', true)
      subject.get_property_value_type('a').should == :boolean
    end

    it "should return :double when a double was set" do
      subject.set_double_property('a', 1.2)
      subject.get_property_value_type('a').should == :double
    end

    it "should return :float when a float was set" do
      subject.set_float_property('a', 1.2)
      subject.get_property_value_type('a').should == :float
    end

    it "should return :long when a long was set" do
      subject.set_long_property('a', 1)
      subject.get_property_value_type('a').should == :long
    end

    it "should return :string when a string was set" do
      subject.set_string_property('a', '1')
      subject.get_property_value_type('a').should == :string
    end
  end

  describe "set_int_property" do
    it "should return what was set" do
      subject.set_int_property('a', 1)
      subject.get_int_property('a').should == 1
    end
  end

  describe "set_boolean_property" do
    it "should return what was set" do
      subject.set_boolean_property('a', true)
      subject.get_boolean_property('a').should == true
    end
  end

  describe "set_double_property" do
    it "should return what was set" do
      subject.set_double_property('a', 1.2)
      subject.get_double_property('a').should be_within(0.01).of(1.2)
    end
  end

  describe "set_float_property" do
    it "should return what was set" do
      subject.set_float_property('a', 1.2)
      subject.get_float_property('a').should be_within(0.01).of(1.2)
    end
  end

  describe "set_long_property" do
    it "should return what was set" do
      subject.set_long_property('a', 1)
      subject.get_long_property('a').should == 1
    end
  end

  skip "set_short_property" do
    it "should return what was set" do
      subject.set_short_property('a', 1)
      subject.get_short_property('a').should == 1
    end
  end

  describe "set_string_property" do
    it "should return what was set" do
      subject.set_string_property('a', '1')
      subject.get_string_property('a').should == '1'
    end
  end

  describe "correlation_id" do
    it "should return what was set" do
      subject.correlation_id = 'abc'
      subject.correlation_id.should == 'abc'
    end
  end

  describe "delivery_mode" do
    it "should return what was set" do
      subject.delivery_mode = ActiveMQ::DeliveryMode::PERSISTENT
      subject.delivery_mode.should == ActiveMQ::DeliveryMode::PERSISTENT
    end
  end
end
