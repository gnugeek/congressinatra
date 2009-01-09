require 'xmlsimple'
require 'net/http'

class Rollcall
  
  def initialize(xml)
    @data = XmlSimple.xml_in(xml)
  end
  
  def data
    @data
  end
  
  def democratic
    @data['results'].first['votes'].first['vote'].first['democratic']
  end
  
  def democratic_majority_position
    democratic.first['majority_position'].first
  end
  
  def democratic_no_votes
    democratic.first['no'].first
  end
  
  def democratic_yes_votes
    democratic.first['yes'].first
  end
  
  def democratic_present
    democratic.first['present'].first
  end
  
  def democratic_not_voting
    democratic.first['not_voting'].first
  end
  
  def republican
    @data['results'].first['votes'].first['vote'].first['republican']
  end
  
  def republican_majority_position
    republican.first['majority_position'].first
  end
  
  def republican_no_votes
    republican.first['no'].first
  end
  
  def republican_yes_votes
    republican.first['yes'].first
  end
  
  def republican_present
    republican.first['present'].first
  end
  
  def republican_not_voting
    republican.first['not_voting'].first
  end
  
  def independent
    @data['results'].first['votes'].first['vote'].first['independent']
  end
  
  def independent_majority_position
    'N/A'
  end
  
  def independent_no_votes
    independent.first['no'].first
  end
  
  def independent_yes_votes
    independent.first['yes'].first
  end
  
  def independent_present
    independent.first['present'].first
  end
  
  def independent_not_voting
    independent.first['not_voting'].first
  end
  
  def result
    @data['results'].first['votes'].first['vote'].first['result'].first
  end
  
  def time
    @data['results'].first['votes'].first['vote'].first['time'].first
  end
  
  def roll_call
    @data['results'].first['votes'].first['vote'].first['roll_call'].first
  end
    
  def congress
    @data['results'].first['votes'].first['vote'].first['congress'].first
  end
  
  def date
    @data['results'].first['votes'].first['vote'].first['date'].first
  end
  
  def bill_number
    data['results'].first['votes'].first['vote'].first['bill_number'].first
  end
  
  def description
    data['results'].first['votes'].first['vote'].first['description'].first
  end
  
  def question
    data['results'].first['votes'].first['vote'].first['question'].first
  end
  
end
