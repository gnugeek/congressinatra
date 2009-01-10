path = File.expand_path(File.dirname(__FILE__))
$LOAD_PATH << path unless $LOAD_PATH.include?(path)

APIKEY = ""

require 'rubygems'
require 'hpricot'
require 'open-uri'
require 'lib/bio'
require 'lib/members'
require 'lib/rollcall'
require 'lib/votes'
