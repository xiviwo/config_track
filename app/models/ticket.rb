class Ticket < ActiveRecord::Base

fields do   
title	:string
ticket_number :string
customer	:string
email	:string
create_date	:date
close_date	:date
status	:string
summary	:text

 timestamps
end
STATUS = %w(hold closed)
belongs_to :assignment
has_one :knowledge
validates_presence_of :title,:ticket_number,:create_date
validates_uniqueness_of :title,:ticket_number

 def to_label
	if !self.assignment.nil?
		logger.debug "self.assignment.ticket_type: #{self.assignment.ticket_type}"
		if !title.nil? && self.assignment.ticket_type ==Assignment::TICKET_TYPE.map(&:to_s)[1] #APP_Owner
		
			ticket_number + ": " + title 
			else 
			ticket_number
		end
	end
 end 

  def assign_date
	 if !self.assignment.nil?
		self.assignment.assign_date
	 end
 end
 
end
