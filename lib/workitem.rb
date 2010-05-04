require 'rubygems'
require 'mongo'

module Workitem
  class << self
    def connect(config)
      @db = Mongo::Connection.new(config[:server],config[:port]||27017).db(config[:db])
    end
    
    def find_all
      workitems = @db.collection("workitems").find.to_a
      return nil_or_array(workitems)
    end
    
    def save(workitem)
      stringify_keys(workitem)
      @db.collection("workitems").save(workitem)
    end
    
    private  
  
  	def stringify_keys(hash)
  		hash.each_key do |key|
  			hash[key.to_s] = hash.delete(key)
  		end
  		hash
  	end
	
    def nil_or_array(result)
  		if result.size == 0
  			return nil
  		else
  			return result
  		end
  	end  
  end
end