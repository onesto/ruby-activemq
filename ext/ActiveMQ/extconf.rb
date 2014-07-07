# Loads mkmf which is used to make makefiles for Ruby extensions
require 'rubygems'
require 'mkmf-rice'

# Add the arguments to the linker flags.
def append_ld_flags(flags)
  flags = [flags] unless flags.is_a?(Array)
  with_ldflags("#{$LDFLAGS} #{flags.join(' ')}") { true }
end

def crash(str)
  printf(" extconf failure: %s\n", str)
  exit 1
end

if RUBY_PLATFORM =~ /darwin/
  # In order to link the shared library into our bundle with GCC 4.x on OSX, we have to work around a bug:
  #   GCC redefines symbols - which the -fno-common prohibits.  In order to keep the -fno-common, we
  #   remove the flat_namespace (we now have two namespaces, which fixes the GCC clash).  Also, we now lookup
  #   symbols in both the namespaces (dynamic_lookup).

  $LDSHARED_CXX.gsub!('suppress', 'dynamic_lookup')
  $LDSHARED_CXX.gsub!('-flat_namespace', '')

  append_ld_flags '-all_load'
end

# Give it a name
extension_name = 'ActiveMQ'

# Gather activemq-cpp configuration
$CFLAGS += ' ' + `activemqcpp-config --cflags`.chomp + ' '
$libs += ' ' + `activemqcpp-config --libs`.chomp + ' '

# The destination
dir_config(extension_name)

# Do the work
create_makefile(extension_name)
