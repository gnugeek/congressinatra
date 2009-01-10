module CongressApi
  
  class Member
    attr_reader :date, :time, :position, :chamber, :congress, :session, :roll_call
    
    def initialize(element)  
      @date = element.search('id').inner_html
      @time = element.search('name').inner_html
      @position = element.search('party').inner_html
      @chamber = element.search('state').inner_html
      @congress = element.search('congress').inner_html
      @session = element.search('session').inner_html
      @roll_call = element.search('roll_call').inner_html
    end
  end
  
  class Members  
    attr_reader :members
      
    def initialize(params)
      @congress = params[:congress]
      @chamber = params[:chamber]
      @members = []
      @url = "http://api.nytimes.com/svc/politics/v2/us/legislative/congress/#{@congress}/#{@chamber}/members?api-key=#{APIKEY}" 
      @doc = parse(@url)
      @doc.search('vote').each do |element|
        @members.push(CongressApi::Vote.new(element))
      end
    end
    
    def parse(url)
       Hpricot.parse(open(@url))
    end
  end
end
