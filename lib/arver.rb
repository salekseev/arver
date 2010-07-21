%w{ singleton yaml fileutils active_support gpgme highline/import }.each {|f| require f }
$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
 
%w{ string script_logic local_config config test_config_loader partition_hierarchy_node partition_hierarchy_root host hostgroup tree partition test_partition key_saver keystore luks_key }.each {|f| require "arver/#{f}" }

module Arver
  VERSION = '0.0.1'
end
