require 'pry'
require 'eventmachine'
require 'em-http'

sites = [
	"http://www.ruby-doc.org",
	"http://eventmachine.rubyforge.org",
	"https://www.github.com",
	"http://www.heroku.com",
	"http://www.igvita.com",
	"http://unknownsite.abc"
	]

EM.run do
	sites.each do |site|
	   request = EM::HttpRequest.new(site).get  #post, put, delete
	   #EM:HttpRequest include deferable
	   request.callback { puts request.response_header.status }
       request.errback { puts "Error"}
    end
    
    EM.add_timer(5) { EM.stop }

EM.add_periodic_timer(1) { puts "tick"}   

#multirequest =======
    # multi_request = EM::MultiRequest.new
    # sites.each do |site| 
    # 	multi_request.add(site, EM::HttpRequest.new(site).get) 
    # end

    # multi_request.callback do
    # 	multi_request.responses[:callback].each do |site, response|   #hash
    # 		puts "#{site}: #{response.response_header.status}"
    # 	end
    # 	multi_request.responses[:errback].each do |site, response|
    # 		puts "#{site}: #{response.response_header.status}"
    # 	end
    # 	EM.stop
    # end
#=====================    
end