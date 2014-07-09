class AssignmentsController < ApplicationController
require 'tempfile' 
 layout 'application'
 active_scaffold do |c|
 c.columns = [:ticket,:ticket_type,:status,:person,:assign_date,:close_date,:link]
 c.list.columns = [:id,:ticket,:customer,:email,:ticket_type,:status,:person,:assign_date,:close_date,:business_days_spent,:link]
 c.create.columns = [:ticket,:ticket_type,:status,:person,:assign_date,:close_date,:link]
 c.update.columns = [:ticket,:ticket_type,:status,:person,:assign_date,:close_date,:link]
 c.columns[:assign_date].description = "Ticket's assign date is generally later then create date!"
 c.columns[:link].options = { :size => 75 }

 #c.columns[:ticket].form_ui = :select
 c.columns[:person].form_ui = :select
 #c.columns[:notes].form_ui = :select
 c.columns[:status].form_ui = :select
 c.columns[:ticket_type].form_ui = :select
 c.columns[:person].label = 'Owner'
 #c.columns[:notes].label = 'Logs'
 #c.columns[:assign_date].form_ui = :datepicker 
 #c.columns[:ticket].set_link "show"
 c.columns[:ticket].actions_for_association_links = [:show]
 c.columns[:person].actions_for_association_links = [:show]
 c.columns[:person].includes = [:person]
 #c.columns[:notes].includes = [:notes]
 c.columns[:ticket].includes = [:ticket]
 c.list.sorting = { :assign_date => :desc }


 
 #c.actions.swap :search, :field_search
 #c.field_search.columns = :person, :assign_date, :close_date,:ticket,:ticket_type,:status
  c.columns[:ticket].search_sql = "CONCAT(tickets.ticket_number, ' ', tickets.title)"
  c.columns[:person].search_sql = "CONCAT(people.name, ' ', people.serial_number)"
  c.search.columns << :ticket
  c.search.columns << :person


 c.columns[:status].options = {:options => Assignment::STATUS.map(&:to_sym),:include_blank => as_(:_select_)}
 c.columns[:ticket_type].options = {:options => Assignment::TICKET_TYPE.map(&:to_sym),:include_blank => as_(:_select_)}
 c.action_links.add 'export_csv', :label => 'To Excel', :page => true
 #c.action_links.add 'to_pdf', :label => 'To PDF', :page => true, :type => :member, :parameters => {:format => 'pdf'}

 end



def export_csv

	book = Spreadsheet::Workbook.new  
	sheet1 = book.create_worksheet 
	sheet1.name = 'Tickets'
	find_options = { :sorting => active_scaffold_config.list.user.sorting }
      
	params[:search] = session[:search]
	
	do_search rescue nil
	params[:segment_id] = session[:segment_id]
	do_segment_search rescue nil
	find_options.merge!({
          :per_page => active_scaffold_config.list.user.per_page,
          :page => active_scaffold_config.list.user.page
        })
	records = find_page(find_options).items
#records = find_page().items

    #return if records.size == 0

    # Note this code is very generic.  We could move this method and the
    # action_link configuration into the ApplicationController and reuse it
    # for all our models.
    #data = []
    cls = records[0].class
    #data << cls.csv_header 
	sheet1.row(0).push 'Ticket','Ticket Type','Status','Owner','Create Date','Assign Date','Close Date','Business Days Spent'
	sheet1.row(0).height = 20 
	sheet1.column(0).width = 10
	sheet1.column(1).width = 14
	sheet1.column(2).width = 10
	sheet1.column(3).width = 10
	sheet1.column(4).width = 14
	sheet1.column(5).width = 15
	sheet1.column(6).width = 14
	sheet1.column(7).width = 25
    format = Spreadsheet::Format.new :pattern_fg_color => :blue,  
									:color => :blue,
                                 :weight => :bold,  
                                 :size => 12,
								 :border => 2,
								 :text_wrap => true
								 
								 
	format2 = Spreadsheet::Format.new :border=>1, 
										:left => 1,
										:right => 1,
										:top => 1,
										:bottom => 1#,,:shrink=>true:text_wrapshrink=> true:border => 2,
										
    sheet1.row(0).default_format = format  
	sheet1.default_format = format2
	i=1
    records.each do |inst|
      data = inst
	  sheet1.update_row i,data.ticket.ticket_number,data.ticket_type,data.status,data.person.name,data.ticket.create_date.nil? ? nil : data.ticket.create_date.strftime('%Y-%m-%d'),data.assign_date.nil? ? nil : data.assign_date.strftime('%Y-%m-%d'),data.close_date.nil? ? nil : data.close_date.strftime('%Y-%m-%d'),data.business_days_spent
	  if !data.link.nil?
	  sheet1[i,0] = Spreadsheet::Link.new data.link, data.ticket.ticket_number
	  end
	  i +=1
    end
	#logger.debug "record count:#{i}"
	tempfile = Tempfile.new("#{ cls.name.pluralize}").path
	#logger.debug "tempfile: #{tempfile}"
    #book.write "c:\\#{ cls.name.pluralize + '.xls'}"
    book.write tempfile
    send_file tempfile,:filename => "export_#{Time.now.strftime("%Y%m%d")}.xls",:type => 'application/vnd.ms-excel'
    #send_file "c:\\#{ cls.name.pluralize + '.xls'}",:type => 'text/xls'

end

	def stat
		@threedays_title = "Three Days' Tickets"
		@fivedays_title = "Five Days' Tickets"
		@Sevendays_title = "Seven Days' Tickets"
		@tendays_title = "Ten Days' Tickets"
		@this_month_title = "This Month's Tickets"
		@this_year_unsolved_title = "This Year's Tickets"
		@this_month_solved_title = "This Month's Tickets" 
		@this_year_title = "This Year's Tickets"
		
		@threedays_sql = ['assignments.assign_date >= ? AND assignments.assign_date <= ? AND assignments.status in (?)', 3.days.ago,Date.today,["hold"]]
		@fivedays_sql = ['assignments.assign_date >= ? AND assignments.assign_date < ? AND assignments.status in (?)', 5.days.ago,3.days.ago,["hold"]]
		@sevendays_sql = ['assignments.assign_date >= ? AND assignments.assign_date < ? AND assignments.status in (?)', 7.days.ago,5.days.ago,["hold"]] 
		@tendays_sql = ['assignments.assign_date >= ? AND assignments.assign_date < ? AND assignments.status in (?)', 10.days.ago,7.days.ago,["hold"]] 
		@this_month_sql = ['assignments.assign_date >= ? AND assignments.assign_date <= ? AND assignments.status in (?)', Date.today.at_beginning_of_month,Date.today.at_end_of_month,["hold"]] 
		@this_year_unsolved_sql = ['assignments.assign_date >= ? AND assignments.assign_date <= ? AND assignments.status in (?)', Date.today.at_beginning_of_year,Date.today.at_end_of_year,["hold"]]
		
		@this_month_solved_sql = ['assignments.assign_date >= ? AND assignments.assign_date <= ? AND assignments.status in (?)', Date.today.at_beginning_of_month,Date.today.at_end_of_month,["closed"]]
		
		@this_year_sql = ['assignments.assign_date >= ? AND assignments.assign_date <= ? AND assignments.status in (?)', Date.today.at_beginning_of_year,Date.today.at_end_of_year,["closed"]]
		
		@treedays = Assignment.count(:conditions => @threedays_sql   )
		@fivedays = Assignment.count(:conditions =>  @fivedays_sql )
		@sevendays = Assignment.count(:conditions => @sevendays_sql )
		@tendays = Assignment.count(:conditions => @tendays_sql )
		@this_month = Assignment.count(:conditions =>  @this_month_sql )
		@this_year_unsolved = Assignment.count(:conditions => @this_year_unsolved_sql  )
		@this_month_solved = Assignment.count(:conditions => @this_month_solved_sql  )
		@this_year = Assignment.count(:conditions => @this_year_sql  )
		#render :partial => 'tickets_table', :locals => {:title => params[:title] , :sql => params[:sql]}
	end
	def my_tickets
		#logger.debug "people: #{current_user.person.object_id}"	
		@mytickets_titile ="My Tickets"
		if params[:id]
		@mytickets_sql = ['assignments.person_id = ?', params[:id]]
		else if !current_user.person.nil?
				@mytickets_sql = ['assignments.person_id = ?', current_user.person.id ]
				else
				@mytickets_sql = ['assignments.person_id = ?',nil]
				end
		end
		
	end	
	def my_unsolved_tickets
		
		@mytickets_titile ="My Unsolved Tickets"
		if !current_user.person.nil?
				@mytickets_sql = ['assignments.person_id = ? AND assignments.status in (?)', current_user.person.id, Assignment::STATUS.map(&:to_s)[0] ]# "hold"
				else
				@mytickets_sql = ['assignments.person_id = ?', nil]
		end
	end	
	
	def my_solved_tickets
		
		@mytickets_titile ="My Solved Tickets"
		if !current_user.person.nil?
				@mytickets_sql = ['assignments.person_id = ? AND assignments.status in (?)', current_user.person.id, Assignment::STATUS.map(&:to_s)[1] ]# "hold"
				else
				@mytickets_sql = ['assignments.person_id = ?', nil]
		end
	end
  # def name
    # @condition = "people.id = #{params[:id]}" 
    # index
  # end
  # def status
    # @condition = "self.status = #{params[:id]}" 
    # index
  # end
  # def conditions_for_collection
    # @condition
  # end	
	# def tickets_table
		# @threedays_title = "Three Days' Tickets"
		
		# @threedays_sql = ['assignments.assign_date >= ? AND assignments.assign_date <= ? AND assignments.status in (?)', 3.days.ago,Date.today,["assigned","hold"]]

		# @treedays = Assignment.count(:conditions => @threedays_sql   )
		# render :layout => false
	# end

end
