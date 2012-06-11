require 'eventmachine'

#timers and tick_loop 

EM.run do

  puts "Start EM loop"
  
  EM::Timer.new(10) { puts "Stop EM loop"; EM.stop }

  seconds = 0

  each_second = EM::PeriodicTimer.new(1) do    #or EM.add_periodic_timer(1){}
    puts "second #{seconds}"
    seconds += 1
  end

  tick_loop = EM.tick_loop do  #or EM::TickLoop.new{}
    each_second.cancel if seconds > 3
  end    

  tick_loop.on_stop { puts "Stopped"}


  EM.add_timer(7) do   #or EM::Timer.new(7){}
    puts "Stop tick_loop" 
    tick_loop.stop
  end  

end