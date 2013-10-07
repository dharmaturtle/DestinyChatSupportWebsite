class StatsController < ApplicationController

#Started GET "/stats" for 127.0.0.1 at 2012-01-31 14:25:08 -0800
#  Processing by StatsController#top as HTML
#   (526841.8ms)  SELECT COUNT(*) AS count_all, nick AS nick FROM `messages` GROUP BY nick ORDER BY count_all DESC LIMIT 100
#Rendered layouts/_flashmessage.erb (0.0ms)
#Rendered stats/top.html.erb within layouts/application (12.7ms)
#Completed 200 OK in 526921ms (Views: 52.7ms | ActiveRecord: 526859.4ms)


	def top
		#unless fragment_exist?("stats")
		  @messages = Message.unscoped.group("nick").count(:order => "count_all DESC", :limit => 100 )
			flash[:notice] = "Stats have been updated!"
		#end
	end
end
