require File.dirname(__FILE__) + '/test_helper'

Expectations do
  params = Hash.new
  params[:member_id] = 'C001041'
  
  rc = CongressApi::Bio.new(params)

  expect CongressApi::Bio do
    rc.class
  end
end