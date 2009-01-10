require File.dirname(__FILE__) + '/test_helper'

Expectations do
  params = Hash.new
  params[:member_id] = 'C001041'
  
  bio = CongressApi::Bio.new(params)

  expect CongressApi::Bio do
    bio.class
  end

  expect 'Hillary Clinton' do
    bio.name
  end
  
  expect '1947-10-26' do
    bio.date_of_birth
  end
  
  expect 'F' do
    bio.gender
  end
  
  expect 'http://clinton.senate.gov' do
    bio.url
  end
  
  expect '300022' do
    bio.govtrack_id
  end
  
  expect CongressApi::Role do
    bio.roles.first
  end
  
  expect '111' do
    bio.roles.first.congress
  end
  
  expect 'Senate' do
    bio.roles.first.chamber
  end
  
  expect 'Senator, 1st Class' do
    bio.roles.first.title
  end
  
  expect 'NY' do
    bio.roles.first.state
  end
  
  expect 'D' do
    bio.roles.first.party
  end
  
  expect '2009-01-06' do
    bio.roles.first.start_date
  end
  
  expect '2011-01-04' do
    bio.roles.first.end_date
  end
  
  
end