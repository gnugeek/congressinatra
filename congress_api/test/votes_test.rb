require File.dirname(__FILE__) + '/test_helper'

Expectations do
  params = Hash.new
  params[:member_id] = 'C001041'
  
  vt = CongressApi::Votes.new(params)

  expect CongressApi::Votes do
    vt.class
  end
  
  expect '2008-12-11' do
    vt.votes.first.date
  end
  
  expect '22:42:00' do
    vt.votes.first.time
  end
  
  expect 'Yes' do 
    vt.votes.first.position
  end
  
  expect 'Senate' do
    vt.votes.first.chamber
  end
  
  expect '110' do
    vt.votes.first.congress
  end
  
  expect '2' do
    vt.votes.first.session
  end
  
  expect '215' do
    vt.votes.first.roll_call
  end
  
end