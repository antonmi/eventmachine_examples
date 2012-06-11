require 'eventmachine'

EM.run do
	array = (1..300000).to_a

#wrong way ====================
  # puts "start"
	# i = 0
	# while i < array.length
      # array[i] = array[i]**2
      # i += 1
	# end
#==============================	

#write way =====================    
 #    i = 0
	# long_task = proc do
 #       if i < array.length 
 #        	array[i] = array[i]**2
 #       		i += 1
 #       		EM.next_tick &long_task
 #       end	  
 # 	end
 #    EM.next_tick &long_task
 #    puts "In progress"
 #=============================
    
#EM::Iterator =================
    EM::Iterator.new(0..array.length-1, 10).each do |i, iter|
       array[i] = array[i]**2
       puts i
       iter.next 
    end
    EM.tick_loop { puts "Waiting"; sleep 1 }
#=============================    
    
#EM.defer ===================
 #    calculation = proc do
 #    	array.map!{ |el| el**2 }
 #     array.last
	# end
 #    callback = proc do |res| 
 #    	puts "Completed with result #{res}"
 #    	EM.stop
 #    end	
   
 # 	i = array.length
 #    EM.defer(calculation, callback)
#================================     

    # EM.add_periodic_timer(0.1) { puts array[i-1] }
end





