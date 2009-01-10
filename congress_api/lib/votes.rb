module CongressApi

  class Vote
    attr_reader :date, :time, :position, :chamber, :congress, :session, :roll_call

    def initialize(element)  
      @date = element.search('date').inner_html
      @time = element.search('time').inner_html
      @position = element.search('position').inner_html
      @chamber = element.search('chamber').inner_html
      @congress = element.search('congress').inner_html
      @session = element.search('session').inner_html
      @roll_call = element.search('roll_call').inner_html
    end
  end
   
  class Votes
    attr_reader :votes, :member_id
    
    def initialize(params)
      @member_id = params[:member_id]
      @votes = []
      @url = "http://api.nytimes.com/svc/politics/v2/us/legislative/congress/members/#{@member_id}/votes?api-key=#{APIKEY}" 
      @doc = parse(@url)
      @doc.search('vote').each do |element|
        @votes.push(CongressApi::Vote.new(element))
      end
    end

    def parse(url)
      Hpricot.parse(open(@url))
    end
  end
  
end