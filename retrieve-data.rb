require 'date'
require 'rest-client'
ENV['NASA_KEY'] = 'YLzx6rwwzEENiaYVxFwPtC8r1VRc0j7BsYB8cRut'

def saveResponse(date,data)
  File.open("retrieval/apod_#{date.to_s}.json",'w') do |f|
    f.write(data)
  end
end

apiKey = ENV['NASA_KEY'] || 'DEMO_KEY'
date = Date.today

urlRoot = "https://api.nasa.gov/planetary/apod?api_key=#{apiKey}"
query = "&date=#{date.to_s}"

res = RestClient.get(urlRoot+query)
saveResponse(date,res.body)

990.times do 
   date -= 1
   query = "&date=#{date.to_s}"
   res = RestClient.get(urlRoot+query)
   saveResponse(date,res.body)
end

