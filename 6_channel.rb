require 'eventmachine'

EM.run do
  channel = EM::Channel.new


  client1 = channel.subscribe { |msg| puts "client1 received #{msg}"} 	
  client2 = channel.subscribe { |msg| puts "client2 received #{msg}"}
  
  i = 0 
  EM.add_periodic_timer(1) do
    channel.push "EventMachine #{i}"
    i += 1
  end   

  #read last message
  EM.add_periodic_timer(2) { channel.pop { |msg| puts msg } }

  #unsubscribe client2
  EM.add_timer(5) { channel.unsubscribe(client2) }


end