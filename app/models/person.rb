class Person < ActiveRecord::Base
fields do   
name	:string
serial_number	:string
 timestamps
end

has_many :assignments
has_many :knowledges
has_one :user

validates_presence_of :name,:serial_number

end
