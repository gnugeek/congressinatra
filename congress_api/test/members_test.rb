require File.dirname(__FILE__) + '/test_helper'

Expectations do
  params = Hash.new
  params[:congress] = 110
  params[:chamber] = 'senate'
  
  rc = CongressApi::Members.new(params)

  expect CongressApi::Members do
    rc.class
  end
  
  expect CongressApi::Member do
    rc.members.first.class
  end
  
  expect 'A000069' do
    rc.members.first.id
  end
  
  expect 'Daniel Akaka' do
    rc.members.first.name
  end
  
  expect 'D' do
    rc.members.first.party
  end
  
  expect 'HI' do
    rc.members.first.state
  end
  
end