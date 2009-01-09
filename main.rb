require 'rubygems'
require 'sinatra/base'
require 'haml'
require 'xmlsimple'
require 'net/http'
require 'rollcall'
require 'members'
require 'votes'
require 'bio'

APIKEY = ""

class Congressinatra < Sinatra::Base
  
  enable :static, :sessions
  set :Root, File.dirname(__FILE__) 
  use_in_file_templates!

  use Rack::Lint
  set :logging, true # use Rack::CommonLogger
  set :sessions, true # use Rack::Session::Cookie

  get '/' do
    haml :index
  end
  
  # http://localhost:3000/congress/109/house/members  
  get '/congress/:congress/:chamber/members' do
    @congress = params[:congress]
    @chamber = params[:chamber]
    url = "http://api.nytimes.com/svc/politics/v2/us/legislative/congress/#{@congress}/#{@chamber}/members?api-key=#{APIKEY}"
    xml_data = Net::HTTP.get_response(URI.parse(url)).body
    m = Members.new(xml_data)
    @m = m.data["results"].first["members"].first["member"]
    haml :members
  end
  
  # http://localhost:3000/congress/members/C001041/votes
  get '/congress/members/:member_id/votes' do
    @member_id = params[:member_id]
    url = "http://api.nytimes.com/svc/politics/v2/us/legislative/congress/members/#{@member_id}/votes?api-key=#{APIKEY}"
    xml_data = Net::HTTP.get_response(URI.parse(url)).body
    @v = Votes.new(xml_data)
    raise @v.inspect
  end
  
  # http://localhost:3000/congress/members/L000447
  get '/congress/members/:member_id' do
    @member_id = params[:member_id]
    url = "http://api.nytimes.com/svc/politics/v2/us/legislative/congress/members/#{@member_id}?api-key=#{APIKEY}"
    xml_data = Net::HTTP.get_response(URI.parse(url)).body
    @b = Bio.new(xml_data)
    raise @b.inspect
  end
  
  # http://localhost:3000/congress/110/senate/sessions/2/votes/194  
  get '/congress/:congress/:chamber/sessions/:session/votes/:votes' do
    @congress = params[:congress]
    @chamber = params[:chamber]
    @session = params[:session]
    @votes = params[:votes]
    url = "http://api.nytimes.com/svc/politics/v2/us/legislative/congress/#{@congress}/#{@chamber}/sessions/#{@session}/votes/#{@votes}?api-key=#{APIKEY}"
    xml_data = Net::HTTP.get_response(URI.parse(url)).body
    @rc = Rollcall.new(xml_data)
    haml :rollcall
  end

  get '/stylesheets/style.css' do
    response['Content-Type'] = 'text/css; charset=utf-8'
    sass :style
  end

end

__END__

@@layout
!!!
%html
  %head
    %title Congressinatra
    %link{:rel=>"stylesheet", :href=>"/stylesheets/style.css", :type => "text/css"}
  %body
    #banner 
      Congressinatra
    #nav 
      %a{:href=>("/")}= "HOME"
      %a{:href=>("/logout" )}= "LOGOUT"
    #content
      = yield

@@index
#content
  Congressinatra is a small test application written with the Ruby "Sinatra" framework.
  Sinatra is a DSL for quickly creating web-applications in Ruby with minimal effort.
  I find Sinatra to be an elegant implementation of the UNIX design philosophy:
  %blockquote
    "Write programs that do one thing and do it well."
  For more information about Sinatra, please see:
  %ul
    %li 
      The Hat:
      %a{:href=>("http://sinatra.rubyforge.org/")}= "http://sinatra.rubyforge.org/"
    %li
      The Book:
      %a{:href=>("http://sinatra.rubyforge.org/book.html")}= "http://sinatra.rubyforge.org/book.html"
    %li 
      The API:
      %a{:href=>("http://sinatra.rubyforge.org/api/")}= "http://sinatra.rubyforge.org/api/"
    %li 
      The Source:
      %a{:href=>("http://github.com/bmizerany/sinatra/tree/master")}= "http://github.com/bmizerany/sinatra/tree/master"
    %li
      Micronatra Source:
      %a{:href=>("http://github.com/gnugeek/micronatra/tree/master")}= "http://github.com/gnugeek/micronatra/tree/master"

@@members
#member_list
%table
  %caption Congressional Members
  %thead
    %tr
      %th name
      %th id
      %th party
      %th state
  %tbody
  - @m.each do |member|
    %tr
      %td= member['name'].first
      %td= member['id'].first
      %td= member['party'].first
      %td= member['state'].first
    
  %tr
    %th
@@rollcall
#bill_info
  %table
    %caption Bill Info
    %tbody
      %tr
        %th Bill Number
        %td= @rc.bill_number
        %tr
        %th Description
        %td= @rc.description

%p

#democratic_vote      
  %table{:id => 'democratic'}
    %caption Democratic Vote
    %tr
      %th Majority Position
      %td= @rc.democratic_majority_position
    %tr
      %th Yes Votes
      %td= @rc.democratic_yes_votes
    %tr
      %th No Votes
      %td= @rc.democratic_no_votes
    %tr
      %th Voted Present
      %td= @rc.democratic_present
    %tr
      %th Not Voting
      %td= @rc.democratic_not_voting

#republican_vote
  %table
    %caption Republican Vote
    %tr
      %th Majority Position
      %td= @rc.republican_majority_position
    %tr
      %th Yes Votes
      %td= @rc.republican_yes_votes
    %tr
      %th No Votes
      %td= @rc.republican_no_votes
    %tr
      %th Voted Present
      %td= @rc.republican_present
    %tr
      %th Not Voting
      %td= @rc.republican_not_voting

#independent_vote
  %table
    %caption Independent Vote
    %tr
      %th Majority Position
      %td= @rc.independent_majority_position
    %tr
      %th Yes Votes
      %td= @rc.independent_yes_votes
    %tr
      %th No Votes
      %td= @rc.independent_no_votes
    %tr
      %th Voted Present
      %td= @rc.independent_present
    %tr
      %th Not Voting
      %td= @rc.independent_not_voting

@@style

a:link
  :color #000
  
body
  :font-family Comic Sans MS

table
  :border 1px solid gray
  :padding 4px
  caption
    :border 1px solid black

#vote_info
  :float top
  
#democratic_vote
  :float left
  
#independent_vote
  :float left
  
#republican_vote
  :float left

#banner
  :text-align left
  :color #fff
  :background #000
  :font-size 18px
  :height 24px
  :padding 2px
  :font-weight bold
  
#content
  :padding 10px 0px

#nav
  :text-align left
  :color #fff
  :background #ccc
  :font-size 14px
  :font-weight bold
  :padding 2px
  
#login-form
  :padding 2px

#footer
  :float bottom
  :text-align right
  :color #fff
  :background #000
  :font-size 12px
  :font-weight bold
  :height 15px  
  :padding 2px
