class Note < ActiveRecord::Base

fields do   
title	:string
create_date	:date
summary	:text
timestamps
end

#belongs_to :assignment
validates_presence_of :title,:create_date,:summary

end
