require File.dirname(__FILE__) + '/test_helper'

Expectations do
  params = Hash.new
  params[:congress] = 110
  params[:chamber] = 'senate'
  params[:session] = '2'
  params[:rollcall] = '194'
  
  rc = CongressApi::Rollcall.new(params)

  expect CongressApi::Rollcall do
    rc.class
  end

  expect 'Yes' do
    rc.democratic_majority_position
  end

  expect '0' do
    rc.democratic_no
  end

  expect '45' do
    rc.democratic_yes
  end

  expect '0' do
    rc.democratic_present
  end

  expect '4' do
    rc.democratic_not_voting
  end

  expect 'Yes' do
    rc.republican_majority_position
  end
  
  expect '8' do
    rc.republican_no
  end
  
  expect '36' do
    rc.republican_yes
  end
  
  expect '1' do
    rc.republican_present
  end
  
  expect '4' do
    rc.republican_not_voting
  end
  
  expect '0' do
    rc.independent_no
  end
  
  expect '2' do
    rc.independent_yes
  end
  
  expect '0' do
    rc.independent_present
  end
  
  expect '0' do
    rc.independent_not_voting
  end
  
  expect 'Agreed to' do
    rc.result
  end
  
  expect '20:26:00' do
    rc.time
  end
  
  expect '194' do
    rc.roll_call
  end
  
  expect '110' do
    rc.congress
  end
  
  expect '2008-07-31' do
    rc.date
  end
  
  expect 'H.R.4137' do
    rc.bill_number
  end
  
  expect 'H.R. 4137 Conference Report; College Opportunity and Affordability Act of 2008' do
    rc.description
  end
  
  expect 'On the Conference Report' do
    rc.question
  end
  
end
