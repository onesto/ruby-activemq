#include "activemq.hpp"


static Object typeCast(cms::Message* message)
{
	cms::TextMessage* textMessage = dynamic_cast<cms::TextMessage*>(message);
	if (textMessage != 0)
		return to_ruby(textMessage);
	return to_ruby(message);
}

static Object receive_1(cms::MessageConsumer* messageConsumer) {
	cms::Message* message = messageConsumer->receive();
	return typeCast(message);
}

void register_MessageConsumer(Module rb_module) {
	void (cms::MessageConsumer::*start)(void) = &cms::MessageConsumer::start;
	void (cms::MessageConsumer::*stop)(void) = &cms::MessageConsumer::stop;
	void (cms::MessageConsumer::*close)(void) = &cms::MessageConsumer::close;

	Data_Type< cms::MessageConsumer > rb_cMessageConsumer =  define_class_under< cms::MessageConsumer >(rb_module, "MessageConsumer");
	rb_cMessageConsumer.define_method("instance?", &instance, (Arg("class")));

	rb_cMessageConsumer.define_method("start", start);
	rb_cMessageConsumer.define_method("stop", stop);
	rb_cMessageConsumer.define_method("close", close);

	rb_cMessageConsumer.define_method("receive", receive_1);
}
