class PeopleController < ApplicationController
  layout 'application'
 active_scaffold :person do |c|
	c.columns = [:name, :serial_number,:user]
	c.actions.swap :search, :field_search
    c.columns[:user].form_ui = :select
 
 end
 
end
