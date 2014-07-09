class KnowledgesController < ApplicationController
   layout 'application'
 active_scaffold do |c|
 c.columns = [:title,:KB_type,:product,:create_date,:symptom,:cause,:resolution,:person]
 c.list.columns = [:title,:KB_type,:product,:create_date,:person]
c.columns[:person].label = 'Owner'
 c.columns[:KB_type].form_ui = :select
 c.columns[:person].form_ui = :select
 #c.columns[:ticket].form_ui = :select
 c.columns[:product].form_ui = :select
 
 c.columns[:symptom].options = { :cols => 100, :rows => 8 }
 c.columns[:cause].options = { :cols => 100, :rows => 8 }
 c.columns[:resolution].options = { :cols => 100, :rows => 8 }
 
 c.actions.swap :search, :field_search
 c.field_search.columns = :person, :create_date, :KB_type,:product,:symptom,:cause,:resolution
 
 c.columns[:KB_type].options = {:options => Knowledge::KB_TYPE.map(&:to_sym),:include_blank => as_(:_select_)}
 c.columns[:product].options = {:options => Knowledge::PRODUCT.map(&:to_sym),:include_blank => as_(:_select_)}
 end
end
