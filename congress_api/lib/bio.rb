module CongressApi
    
  class Role
    attr_reader :congress, :chamber, :title, :state, :party, :start_date, :end_date
    
    def initialize(element)
      @congress = element.search('congress').inner_html
      @chamber = element.search('chamber').inner_html
      @title = element.search('title').inner_html
      @state = element.search('state').inner_html
      @party = element.search('party').inner_html
      @start_date = element.search('start_date').inner_html
      @end_date = element.search('end_date').inner_html
    end
  end
  
  class Bio
    attr_reader :id, :name, :date_of_birth, :gender, :url, :govtrack_id, :roles, :doc
    
    def initialize(params)
      @roles = []
      @member_id = params[:member_id]
      @url = "http://api.nytimes.com/svc/politics/v2/us/legislative/congress/members/#{@member_id}?api-key=#{APIKEY}"
      @doc = parse(@url)
      @name = @doc.search('//member/name').first.inner_html
      @date_of_birth = @doc.search('//member/date_of_birth').first.inner_html
      @gender = @doc.search('//member/gender').first.inner_html
      @url = @doc.search('//member/url').first.inner_html
      @govtrack_id = @doc.search('//member/govtrack_id').first.inner_html
      
      @doc.search('member/roles/role').each do |element|
        @roles.push(CongressApi::Role.new(element))
      end
    end
  
    def parse(url)
       Hpricot.parse(open(@url))
    end
  end
end
