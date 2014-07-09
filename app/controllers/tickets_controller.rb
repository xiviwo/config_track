class TicketsController < ApplicationController
   layout 'application'
 active_scaffold do |c|
 c.columns = [:ticket_number,:title,:customer,:email,:create_date]
 c.list.columns = [:ticket_number,:title,:customer,:email,:create_date,:assign_date,:close_date]
 c.show.columns = [:ticket_number,:title,:customer,:email,:create_date,:assign_date,:close_date]
 #c.update.columns = [:ticket_number,:title,:create_date,:summary]
 #c.create.columns = [:ticket_number,:title,:create_date,:summary]
  c.columns[:create_date].description = "Ticket's create date is generally earlier then assign date!"
 #c.columns[:assignment].form_ui = :select
 c.columns[:summary].options = { :cols => 100, :rows => 15 }
 #c.columns[:knowledge].actions_for_association_links = [:show]
 c.subform.layout = :vertical
 c.columns[:status].form_ui = :select
 c.columns[:knowledge].form_ui = :select
 c.columns[:status].options = {:options => Ticket::STATUS.map(&:to_sym)}
 
 c.actions.swap :search, :field_search
 c.field_search.columns = :title,:ticket_number, :create_date, :close_date
 end

end
