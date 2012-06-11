require 'eventmachine'
require 'em-websocket'

EM.run do
	puts "Starting websocket server"

    EM::WebSocket.start(:host => "localhost", :port => 9999) do |ws|
      
      ws.onopen { puts "Client connected" }

      ws.onclose { puts "Client disconnected" }
        
 	  ws.onerror { puts "Error" }
         
      ws.onmessage do |msg|
        puts "Received: #{msg}" 
      	ws.send "Server recieved #{msg}"
      end	
    end
end

=begin

var socket = new WebSocket('ws://localhost:9999');
    
socket.onopen = function() { console.log("Connected") };

socket.onmessage = function(message) { console.log(message.data) };

socket.onerror = function(error) { console.log("Error") };

socket.onclose = function() { console.log("Disconnected") };

=end