module CongressApi
  class Votes
    
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
      @member_id = params[:member_id]
      @url = "http://api.nytimes.com/svc/politics/v2/us/legislative/congress/members/#{@member_id}/votes?api-key=#{APIKEY}"
      @doc = parse(@url)
    end
  
    def parse(url)
       Hpricot.parse(open(@url))
    end
  end
end
