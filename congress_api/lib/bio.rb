module CongressApi
  class Bio
    def initialize(xml)
      @data = XmlSimple.xml_in(xml)
    end
  
    def data
      @data
    end
  end
end
