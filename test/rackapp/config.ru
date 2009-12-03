require 'app'
require File.join(File.dirname(__FILE__), '..', '..', 'lib', 'rack-gsub')

use Rack::Gsub, "to" => "2", "in" => "N", "are" => "R"

run App.new
