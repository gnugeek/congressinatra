path = File.expand_path(File.dirname(__FILE__))
$LOAD_PATH << path unless $LOAD_PATH.include?(path)

require 'rubygems'
require 'hpricot'
require 'open-uri'
require 'lib/bio'
require 'lib/members'
require 'lib/rollcall'
require 'lib/votes'

APIKEY = '32cba725aa2f8bad440a7d428f3ef23f:11:57686948'