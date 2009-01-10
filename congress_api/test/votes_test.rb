require File.dirname(__FILE__) + '/test_helper'

Expectations do
  params = Hash.new
  params[:member_id] = 'C001041'
  
  rc = CongressApi::Votes.new(params)

  expect CongressApi::Votes do
    rc.class
  end
end