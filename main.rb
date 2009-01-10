require 'rubygems'
require 'sinatra/base'
require 'haml'
require 'yaml'
require 'congress_api/base'

class Congressinatra < Sinatra::Base
  
  enable :static, :sessions
  set :Root, File.dirname(__FILE__) 

  use Rack::Lint
  set :logging, true
  set :sessions, true

  get '/' do
    haml :index
  end
  
  # http://localhost:3000/congress/109/house/members  
  get '/congress/:congress/:chamber/members' do
    @members = CongressApi::Members.new(params)
    haml :members
  end
  
  # http://localhost:3000/congress/members/C001041/votes
  get '/congress/members/:member_id/votes' do
    @votes = CongressApi::Votes.new(params)
    haml :votes
  end
  
  # http://localhost:3000/congress/members/L000447
  get '/congress/members/:member_id' do
    @bio = CongressApi::Bio.new(params)
    haml :bio
  end
  
  # http://localhost:3000/congress/110/senate/sessions/2/votes/194  
  get '/congress/:congress/:chamber/sessions/:session/votes/:rollcall' do
    @rc = CongressApi::Rollcall.new(params)
    haml :rollcall
  end

  get '/stylesheets/style.css' do
    response['Content-Type'] = 'text/css; charset=utf-8'
    sass :style
  end

end
