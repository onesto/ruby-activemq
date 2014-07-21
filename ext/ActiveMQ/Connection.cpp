#include "activemq.hpp"

void register_Connection(Module rb_module) {
	void (cms::Connection::*start)(void) = &cms::Connection::start;
	void (cms::Connection::*stop)(void) = &cms::Connection::stop;
	void (cms::Connection::*close)(void) = &cms::Connection::close;

	cms::Session* (cms::Connection::*Connection_createSession1)(cms::Session::AcknowledgeMode) = &cms::Connection::createSession;

	Data_Type< cms::Connection > rb_cConnection =  define_class_under< cms::Connection >(rb_module, "Connection");
	rb_cConnection.define_method("instance?", &instance, (Arg("class")));

	rb_cConnection.define_method("start", start);
	rb_cConnection.define_method("stop", stop);
	rb_cConnection.define_method("close", close);

	rb_cConnection.define_method("create_session", Connection_createSession1, (Arg("acknowledge_mode") = cms::Session::AUTO_ACKNOWLEDGE));

	rb_cConnection.define_method("client_id", &cms::Connection::getClientID);
	rb_cConnection.define_method("client_id=", &cms::Connection::setClientID, (Arg("client_id")));
}
