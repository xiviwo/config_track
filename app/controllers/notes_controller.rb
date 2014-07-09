class NotesController < ApplicationController
  layout 'application'
 active_scaffold do |c|
 c.columns = [:title,:create_date,:summary,:assignment]
 c.list.columns = [:title,:create_date,:assignment]
 c.columns[:assignment].form_ui = :select
 c.columns[:summary].options = { :cols => 100, :rows => 8 }
 end
end
