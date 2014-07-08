#include "activemq.hpp"

static Object getPropertyValueType(cms::Message* message, const std::string& name)
{
	switch (message->getPropertyValueType(name)) {
	case cms::Message::NULL_TYPE:       return Rice::Symbol("null");
	case cms::Message::BOOLEAN_TYPE:    return Rice::Symbol("boolean");
	case cms::Message::BYTE_TYPE:       return Rice::Symbol("byte");
	case cms::Message::CHAR_TYPE:       return Rice::Symbol("char");
	case cms::Message::SHORT_TYPE:      return Rice::Symbol("short");
	case cms::Message::INTEGER_TYPE:    return Rice::Symbol("integer");
	case cms::Message::LONG_TYPE:       return Rice::Symbol("long");
	case cms::Message::DOUBLE_TYPE:     return Rice::Symbol("double");
	case cms::Message::FLOAT_TYPE:      return Rice::Symbol("float");
	case cms::Message::STRING_TYPE:     return Rice::Symbol("string");
	case cms::Message::BYTE_ARRAY_TYPE: return Rice::Symbol("byte_array");
	default:                            return Rice::Symbol("unknown");
	}
}

void register_Message(Module rb_module) {
	Data_Type< cms::Message > rb_cMessage = define_class_under< cms::Message >(rb_module, "Message");

	rb_cMessage.const_set("DEFAULT_DELIVERY_MODE", to_ruby(cms::Message::DEFAULT_DELIVERY_MODE));
	rb_cMessage.const_set("DEFAULT_MSG_PRIORITY", to_ruby(cms::Message::DEFAULT_MSG_PRIORITY));
	rb_cMessage.const_set("DEFAULT_TIME_TO_LIVE", to_ruby(cms::Message::DEFAULT_TIME_TO_LIVE));

	rb_cMessage.define_method("instance?", &instance, (Arg("class")));

	rb_cMessage.define_method("get_int_property", &cms::Message::getIntProperty, (Arg("name")));
	rb_cMessage.define_method("set_int_property", &cms::Message::setIntProperty, (Arg("name"), Arg("value")));
//
//	rb_cMessage.define_method("getByteProperty", &cms::Message::getByteProperty, (Arg("name")));
//	rb_cMessage.define_method("setByteProperty", &cms::Message::setByteProperty, (Arg("name"), Arg("value")));
//
	rb_cMessage.define_method("get_boolean_property", &cms::Message::getBooleanProperty, (Arg("name")));
	rb_cMessage.define_method("set_boolean_property", &cms::Message::setBooleanProperty, (Arg("name"), Arg("value")));
//
	rb_cMessage.define_method("get_double_property", &cms::Message::getDoubleProperty, (Arg("name")));
	rb_cMessage.define_method("set_double_property", &cms::Message::setDoubleProperty, (Arg("name"), Arg("value")));

	rb_cMessage.define_method("get_float_property", &cms::Message::getFloatProperty, (Arg("name")));
	rb_cMessage.define_method("set_float_property", &cms::Message::setFloatProperty, (Arg("name"), Arg("value")));

	rb_cMessage.define_method("get_long_property", &cms::Message::getLongProperty, (Arg("name")));
	rb_cMessage.define_method("set_long_property", &cms::Message::setLongProperty, (Arg("name"), Arg("value")));

	rb_cMessage.define_method("get_short_property", &cms::Message::getShortProperty, (Arg("name")));
	rb_cMessage.define_method("set_short_property", &cms::Message::setShortProperty, (Arg("name"), Arg("value")));

	rb_cMessage.define_method("get_string_property", &cms::Message::getStringProperty, (Arg("name")));
	rb_cMessage.define_method("set_string_property", &cms::Message::setStringProperty, (Arg("name"), Arg("value")));
//
//	rb_cMessage.define_method("clone", &cms::Message::clone);

//	rb_cMessage.define_method("acknowledge", &cms::Message::acknowledge);
//	rb_cMessage.define_method("clearBody", &cms::Message::clearBody);
//	rb_cMessage.define_method("clearProperties", &cms::Message::clearProperties);

	rb_cMessage.define_method("property_exists?", &cms::Message::propertyExists, (Arg("name")));
	rb_cMessage.define_method("property_names", &cms::Message::getPropertyNames);
	rb_cMessage.define_method("get_property_value_type", &getPropertyValueType, (Arg("name")));
//
//	rb_cMessage.define_method("destination", &cms::Message::getCMSDestination);
//	rb_cMessage.define_method("destination=", &cms::Message::setCMSDestination, (Arg("destination")));
//
//	rb_cMessage.define_method("expiration", &cms::Message::getCMSExpiration);
//	rb_cMessage.define_method("expiration=", &cms::Message::setCMSExpiration, (Arg("expireTime")));
//
//	rb_cMessage.define_method("message_id", &cms::Message::getCMSMessageID);
//	rb_cMessage.define_method("message_id=", &cms::Message::setCMSMessageID, (Arg("id")));
//
//	rb_cMessage.define_method("priority", &cms::Message::getCMSPriority);
//	rb_cMessage.define_method("priority=", &cms::Message::setCMSPriority, (Arg("priority")));
//
//	rb_cMessage.define_method("redelivered?", &cms::Message::getCMSRedelivered);
//	rb_cMessage.define_method("redelivered=", &cms::Message::setCMSRedelivered, (Arg("redelivered")));
//
//	rb_cMessage.define_method("reply_to", &cms::Message::getCMSReplyTo);
//	rb_cMessage.define_method("reply_to=", &cms::Message::setCMSReplyTo, (Arg("destination")));
//
//	rb_cMessage.define_method("timestamp", &cms::Message::getCMSTimestamp);
//	rb_cMessage.define_method("timestamp=", &cms::Message::setCMSTimestamp, (Arg("timeStamp")));
//
//	rb_cMessage.define_method("type", &cms::Message::getCMSType);
//	rb_cMessage.define_method("type=", &cms::Message::setCMSType, (Arg("type")));
//
	rb_cMessage.define_method("correlation_id", &cms::Message::getCMSCorrelationID);
	rb_cMessage.define_method("correlation_id=", &cms::Message::setCMSCorrelationID, (Arg("correlation_id")));

	rb_cMessage.define_method("delivery_mode", &cms::Message::getCMSDeliveryMode);
	rb_cMessage.define_method("delivery_mode=", &cms::Message::setCMSDeliveryMode, (Arg("delivery_mode")));
}
