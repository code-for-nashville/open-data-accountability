class HomeController < ApplicationController
  def index
    if !params["/"].nil? and params["/"]["dataSet"].present?
      api_data = HTTParty.get("https://data.#{params['/']['dataSet']}.gov/data.json", :verify => false)
      api_data['dataset'].each do |data|
        Dataset.where(:identifier=>data['identifier']).first_or_create(
          :date_created=>data['issued'],
          :date_updated=>data['modified'],
          :category=>data['landingPage'],
          :title=>data['title']
        )
      end
      data = Dataset.where("identifier like '%#{params['/']['dataSet']}%'")
      @city = params["/"]["dataSet"]
      @chart_data = data.pluck(:title, :date_created, :date_updated)
      @count = data.count
      @created_this_month = data.where(:date_created => 1.month.ago..Time.now).pluck(:title, :category, :date_created)
      @updated_this_month = data.where(:date_updated => 1.month.ago..Time.now).pluck(:title, :category, :date_updated)
    else
      api_data = HTTParty.get('https://data.nashville.gov/data.json')
      api_data['dataset'].each do |data|
        Dataset.where(:identifier=>data['identifier']).first_or_create(
          :date_created=>data['issued'],
          :date_updated=>data['modified'],
          :category=>data['landingPage'],
          :title=>data['title']
        )
      end
      data = Dataset.where("identifier like '%nashville%'")
      @chart_data = data.pluck(:title, :date_created, :date_updated)
      @count = data.count
      @created_this_month = data.where(:date_created => 1.month.ago..Time.now).pluck(:title, :category)
      @updated_this_month = data.where(:date_updated => 1.month.ago..Time.now).pluck(:title, :category)
    end
  end
end
