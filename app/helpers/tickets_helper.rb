module TicketsHelper

  def email_column(record)
	if !record.email.nil?
    mail_to record.email, record.email
	end
  end
  

def create_date_form_column(record,input_name)
	
	if record.id.nil?
	calendar_date_select_tag :record,Date.today,input_name
	else
	calendar_date_select_tag :record,record.create_date,input_name
	end
end


end
