class HomeController < ApplicationController
  def index
    # Nashville by default
    @city = (!params["/"].nil? and params["/"]["dataSet"].present?) ? params['/']['dataSet'] : "nashville"
    api_data = HTTParty.get("https://data.#{@city}.gov/data.json", :verify => false)
    api_data['dataset'].each do |data|
      Dataset.where(:identifier=>data['identifier']).first_or_create(
        :date_created=>data['issued'],
        :date_updated=>data['modified'],
        :category=>data['theme'][0],
        :title=>data['title']
      )
    end
    data = Dataset.where("identifier like '%#{@city}%'")
    categories = data.pluck(:category).uniq
    @chart_data = data.pluck(:title, :date_created, :date_updated)
    @count = data.count
    @created_this_month = data.where(:date_created => 1.month.ago..Time.now).pluck(:title, :category)
    @updated_this_month = data.where(:date_updated => 1.month.ago..Time.now).pluck(:title, :category)
  end
end
