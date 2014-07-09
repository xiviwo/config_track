module AssignmentsHelper

	#helper :Tickets

  def link_column(record)
	if !record.link.nil?
    link_to "Link to Ticket", record.link,:popup => true 
	end
  end
  
def assign_date_form_column(record,input_name)

	if record.id.nil?
	calendar_date_select_tag :record,Date.today,input_name
	else
	calendar_date_select_tag :record,record.assign_date,input_name
	end
end

def person_form_column(record,input_name)

	if !current_user.person.nil? && record.person.nil?
	select record,:person,Person.all.collect {|p| [ p.name, p.id ] }, {:include_blank => as_(:_select_),:selected => current_user.person.id},input_name
	else if !record.person.nil?
		select record,:person,Person.all.collect {|p| [ p.name, p.id ] }, {:include_blank => as_(:_select_),:selected => record.person.id},input_name
		else

		select record,:person,Person.all.collect {|p| [ p.name, p.id ] }, {:include_blank => as_(:_select_)},input_name
		end
	end
end


  def link_to_partial(title,sql)
		link_to_function(title, nil, :id => "tickets_link") do |page|
		
			#page.visual_effect :puff, 'tickets'
			page.visual_effect :appear, 'tickets'
			#page.visual_effect :shake, 'tickets'
			#page.visual_effect :shrink, 'tickets'
			page.visual_effect :highlight, 'tickets'
			#page.visual_effect :morph, 'tickets'
			#page.visual_effect :opacity, 'tickets'
			#page.visual_effect :scale, 'tickets'
			page.replace_html 'tickets', :partial => 'tickets_table',:locals => { :title => title , :sql =>sql }

		end 
  end
  
  def ticket_table(title,sql)
	  render :active_scaffold => 'assignments', :label => title , :conditions => sql
  end
  
end
