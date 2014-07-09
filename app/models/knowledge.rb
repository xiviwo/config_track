class Knowledge < ActiveRecord::Base
fields do   
title	:string
create_date :date
symptom :text
cause	:text
resolution :text
KB_type	:string
product :string
timestamps
end
KB_TYPE = %w(Application_Owner Lotus_Notes_Support operation)
PRODUCT = %w(Lotus_Notes Symphony Sametime Adobe_Reader Adobe_Flash Office_2002 Office_2003)
belongs_to :person
belongs_to :ticket
validates_presence_of :title,:create_date,:KB_type,:product

end
