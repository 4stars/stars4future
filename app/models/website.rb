class Website < ActiveRecord::Base
	
	has_many :products, :dependent => :destroy
	has_many :services, :dependent => :destroy
	has_many :contact_address, :dependent => :destroy

end
