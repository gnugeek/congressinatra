# http://localhost:3000/congress/110/senate/sessions/2/votes/194 

module CongressApi
  class Rollcall

    LOOKUP = {
      :democratic_majority_position  => 'democratic/majority_position',
      :democratic_no => 'democratic/no',
      :democratic_yes => 'democratic/yes',
      :democratic_present => 'democratic/present',
      :democratic_not_voting => 'democratic/not_voting',
      :republican_majority_position  => 'republican/majority_position',
      :republican_no => 'republican/no',
      :republican_yes => 'republican/yes',
      :republican_present => 'republican/present',
      :republican_not_voting => 'republican/not_voting',
      :independent_no => 'independent/no',
      :independent_yes => 'independent/yes',
      :independent_present => 'independent/present',
      :independent_not_voting => 'independent/not_voting',
      :result => 'result',
      :time => 'time',
      :roll_call => 'roll_call',
      :congress => 'congress',
      :date => 'date',
      :bill_number => 'bill_number',
      :description => 'description',
      :question => 'question',
    }
  
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
      @session = params[:session]
      @rollcall = params[:rollcall]
      @url = "http://api.nytimes.com/svc/politics/v2/us/legislative/congress/#{@congress}/#{@chamber}/sessions/#{@session}/votes/#{@rollcall}?api-key=#{APIKEY}" 
      @doc = parse(@url)
    end
    
    def parse(url)
      Hpricot.parse(open(@url))
    end
    
  end
end
