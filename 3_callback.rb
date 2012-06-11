require 'eventmachine'

#EM.Callback is utility method for coercing argumetns 
#to an object that responds to :call

EM.run do 

#EM.Callback{ do_smth }
callback = EM.Callback { |arg| puts "Hello #{arg}"}
callback.call("EventMachine")
#===========

#EM.Callback(proc { do_smth })
callback = EM.Callback proc { |arg| puts "Hello #{arg}" }
callback.call("EventMachine")
#===========

#EM.Callback(obj, method)
callback = EM.Callback(Kernel, :puts) #delegate to Kernel#puts 
callback.call("Hello EventMachine") 
#===========

EM.stop

end