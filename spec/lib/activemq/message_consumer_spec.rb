# -*- encoding: utf-8 -*-
require 'spec_helper'

describe ActiveMQ::MessageConsumer do

  let :session do
    ActiveMQ::ConnectionFactory.new(BROKER_URL_TEST).create_connection.create_session
  end

  let :queue do
    session.create_queue("TEST_MESSAGE_CONSUMER")
  end

  let :producer do
    session.create_producer(queue)
  end

  let :consumer do
    session.create_consumer(queue)
  end

  describe "attributes" do
  end

  describe "receive message" do
    it "should be possible send a message" do
      p_connection = ActiveMQ::ConnectionFactory.new(BROKER_URL_TEST).create_connection
      begin
        p_connection.start()
        c_connection = ActiveMQ::ConnectionFactory.new(BROKER_URL_TEST).create_connection
        begin
          c_connection.start()
          p_session = p_connection.create_session
          p_queue = p_session.create_queue("TEST_MESSAGE_CONSUMER")
          begin
            p_session.start()
            c_session = c_connection.create_session
            c_queue = p_session.create_queue("TEST_MESSAGE_CONSUMER")
            begin
              c_session.start()
              producer = p_session.create_producer(p_queue)
              message_out = p_session.create_text_message "TEST_MESSAGE"
              message_out.message_id = '1234'

              consumer = c_session.create_consumer(c_queue)
              begin
                consumer.start()
                producer.send_message(message_out)
                message_in = consumer.receive()
                message_in.text.should == message_out.text
                consumer.stop()
              ensure
                consumer.close
              end
            ensure
              c_session.close
            end
          ensure
            p_session.close
          end
        ensure
          c_connection.close
        end
      ensure
        p_connection.close
      end
    end
  end
end
