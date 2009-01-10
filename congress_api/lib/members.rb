module CongressApi
  class Member
    attr_reader :id, :name, :party, :state
    
    def initialize(element)  
      @id = element.search('id').inner_html
      @name = element.search('name').inner_html
      @party = element.search('party').inner_html
      @state = element.search('state').inner_html
    end
  end
  
  class Members
    
    attr_reader :members
    
    LOOKUP = {}
    
    self.instance_eval do
      LOOKUP.each_key do |symbol|
        define_method(symbol) { @doc.search(LOOKUP[symbol]).inner_html }
      end
    
      define_method(:to_hash) do
        h = {}
        LOOKUP.each_key {|k| h[k] = self.send(k) }
        return h
      end
    end
      
    def initialize(params)
      @congress = params[:congress]
      @chamber = params[:chamber]
      @members = []
      @url = "http://api.nytimes.com/svc/politics/v2/us/legislative/congress/#{@congress}/#{@chamber}/members?api-key=#{APIKEY}" 
      @doc = parse(@url)
      @doc.search('member').each do |element|
        @members.push(CongressApi::Member.new(element))
      end
    end
  
    def parse(url)
       Hpricot.parse(open(@url))
    end
  end
end
