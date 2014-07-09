class Assignment < ActiveRecord::Base
before_save :set_close_date
#validate  :check_close_date

fields do   
title	:string
assign_date	:date
close_date	:date
status	:string
link	:string
ticket_type :string
 timestamps
end
STATUS = %w(hold closed)
TICKET_TYPE = %w(Notes_Support App_Owner)
has_one :ticket
#has_many :notes
belongs_to :person

validates_presence_of :assign_date,:status,:ticket_type,:person,:ticket
#validates_uniqueness_of :link

#validates_presence_of :check_close_date,:message => "close_date can't be blank in order to close ticket!"

# def title
	# if !person.nil? && !ticket.nil? 
		# self.person.name + "'s " + self.ticket.title
	# end
# end
def customer
	if !self.ticket.nil?
		self.ticket.customer
	end
end

def email
	if !self.ticket.nil?
		self.ticket.email
	end
end

def  set_close_date
	 if !self.ticket.nil? && self.ticket.close_date != self.close_date
		self.ticket.close_date = self.close_date
	 end
end
def validate
	#logger.debug "status: #{self.status}"
	#logger.debug "close_date: #{self.close_date}"
	
	if (self.status == "resolved" || self.status == "closed")  && self.close_date.nil?
	errors.add(:close_date, "can't be blank in order to close ticket!")
	end
	if !self.ticket.nil? && !self.assign_date.nil?
		if self.ticket.create_date > self.assign_date
			errors.add(:assign_date, ": Assignment(#{self.assign_date}) happens earler than ticket-creation(#{self.ticket.create_date}), impossible!")
		end
	end
	if !self.close_date.nil? && !self.assign_date.nil?
		if self.assign_date > self.close_date
			errors.add(:close_date, ": Ticket (#{self.close_date}) closes earlier than assignment(#{self.assign_date}), not possible!")
		end
	end
	

end

def business_days_between(small_date, big_date)

  business_days = 0
  if small_date.nil? 
     business_days = 0
  else  if big_date.nil? 
		   big_date = Date.today
		end   
		if small_date >= big_date
					#logger.debug "small_date: #{small_date}"
			         #logger.debug "big_date: #{big_date}"
					business_days = 0
					else
					sunday = 0
					saturday = 6
					weekend = [saturday, sunday]
					business_days = 0
					date = big_date
					#logger.debug "date > small_date: #{date > small_date}"
				  while date > small_date
				  #logger.debug "date week day : #{date.wday}"
				  #logger.debug "weekend? : #{weekend.include?(date.wday)}"
				  
				   business_days = business_days + 1 unless weekend.include?(date.wday)
				   date = date - 1.day
				  end
		end
		
  end 
  business_days
end

def business_days_spent

	business_days_between(assign_date,close_date)

end


end
