:------------------------- WARNING ! ----------------------
:         This file is GENERATED by Instant Rails.
:
: If you need to make changes to this file, you should edit
: the source template file instead. The source template is
: H:\InstantRails\conf_files\use_ruby.cmd
:-----------------------------------------------------------
cd ..
cd ..
set PWD=%cd%
PATH %PWD%\ruby\bin;%PWD%\mysql\bin;%PATH%
cd rails_apps
cd track
call mongrel_rails service::remove -N tickettracking 
 