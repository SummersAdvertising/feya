class Article < ActiveRecord::Base
  has_many :photos, :dependent => :destroy
  attr_accessible :content, :name

  #delete the blank diretory built by carrierwave
  before_destroy :remember_id
  after_destroy :remove_id_directory
  
  has_one :draft

  def get_meta

	begin		  
	  	parts = JSON.parse(self.content)
	  	
	  	meta = ''
	  	
	  	parts.each do | part |
	  		break if meta.length > 100
	  		next if part['type'] != 'p'
	  		
	  		meta += part['content']
	  		
	  	end
	  	
	  	return meta
  	
	rescue
		return 'Meta fetch error.'
	end
	  	
  end

  def erase_draft
  	self.draft.destroy
  end
  
  def drafting
  	
  	self.draft.build( { name: self.name, content: self.content } )
  	
  	self.draft.save
  	
  end

  def publish
  	
  	self.name = self.draft.name
  	self.content = self.draft.content
  	
  	erase_draft
  	
  end

  protected
  def remember_id
    @id = id
  end
  

  def remove_id_directory
    FileUtils.remove_dir("#{Rails.root}/public/uploads/#{@id}", :force => true)
  end
end
