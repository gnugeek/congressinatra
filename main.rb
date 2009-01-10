require 'rubygems'
require 'sinatra/base'
require 'haml'
require 'yaml'
require 'congress_api/base'

class Congressinatra < Sinatra::Base
  
  enable :static, :sessions
  set :Root, File.dirname(__FILE__) 
  use_in_file_templates!

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
    #content
      = yield

@@index
#content
  
  Congressinatra is a small test application written with the Ruby "Sinatra" framework.
   
  %h3 Sample Queries
  %ul
    %li
      %a{:href=>("http://localhost:3000/congress/109/house/members")}= "http://localhost:3000/congress/109/house/members"
    %li
      %a{:href=>("http://localhost:3000/congress/members/C001041/votes")}= "http://localhost:3000/congress/members/C001041/votes"
    %li
      %a{:href=>("http://localhost:3000/congress/members/L000447")}= "http://localhost:3000/congress/members/L000447"
    %li
      %a{:href=>("http://localhost:3000/congress/110/senate/sessions/2/votes/194")}= "http://localhost:3000/congress/110/senate/sessions/2/votes/194"
      
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

@@votes
#votes
%table
  %caption= "Votes for #{@member_id}"
  %thead
    %tr
      %th chamber
      %th time
      %th date
      %th roll_call
      %th session
      %th congress
      %th position
      %th rollcall
  %tbody
  - @votes.votes.each do |vote|
    %tr
      %td= vote.chamber
      %td= vote.time
      %td= vote.date
      %td= vote.roll_call
      %td= vote.session
      %td= vote.congress
      %td= vote.position
      %td
        %a{:href=>("/congress/#{vote.congress}/#{vote.chamber}/sessions/#{vote.session}/votes/#{vote.roll_call}")}= "link"

@@bio
#bio
%table
  %caption Bio Information
  %tbody
    %tr
      %th id
      %td= @bio.member_id
    %tr
      %th name
      %td= @bio.name
    %tr
      %th date_of_birth
      %td= @bio.date_of_birth
    %tr
      %th gender
      %td= @bio.gender
    %tr
      %th url
      %td= @bio.url
    %tr
      %th govtrack_id
      %td= @bio.govtrack_id
      
%table
  %caption Roles
  %thead
    %tr
      %th congress
      %th chamber
      %th title
      %th state
      %th party
      %th start_date
      %th end_date
  %tbody
  - @bio.roles.each do |role|
    %tr
      %td= role.congress
      %td= role.chamber
      %td= role.title
      %td= role.state
      %td= role.party
      %td= role.start_date
      %td= role.end_date
    
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
      %th record
  %tbody
  - @members.members.each do |member|
    %tr
      %td= member.name
      %td= member.id
      %td= member.party
      %td= member.state
      %td
        %a{:href=>("http://localhost:3000/congress/members/#{member.id}/votes")}= "link"
    
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
      %td= @rc.democratic_yes
    %tr
      %th No Votes
      %td= @rc.democratic_no
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
      %td= @rc.republican_yes
    %tr
      %th No Votes
      %td= @rc.republican_no
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
      %td= 'N/A'
      
    %tr
      %th Yes Votes
      %td= @rc.independent_yes
    %tr
      %th No Votes
      %td= @rc.independent_no
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
