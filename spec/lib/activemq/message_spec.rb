# -*- encoding: utf-8 -*-
require 'spec_helper'

describe ActiveMQ::Message do
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
end
