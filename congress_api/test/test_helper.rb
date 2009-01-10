require 'rubygems'
require 'expectations'

require File.dirname(__FILE__)+'./base'

rollcall_response = File.read('responses/rollcall.xml')
bio_response = File.read('responses/bio.xml')
members_response = File.read('responses/members.xml')
votes.response = File.read('responses/votes.xml')