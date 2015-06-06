class HomeController < ApplicationController
  def index
    nash_api_data = HTTParty.get('https://data.nashville.gov/data.json')
    nash_api_data['dataset'].each do |data|
      Dataset.where(:identifier=>data['identifier']).first_or_create(
        :date_created=>data['issued'],
        :date_updated=>data['modified'],
        :category=>data['landingPage'],
        :title=>data['title']
      )
    end
    @nash_chart_data = Dataset.where("identifier like '%nashville%'").pluck(:title, :date_created, :date_updated)
    @nash_count = Dataset.where("identifier like '%nashville%'").count
    @created_this_month = Dataset.where(:date_created => 1.month.ago..Time.now).pluck(:title, :category)
    @updated_this_month = Dataset.where(:date_updated => 1.month.ago..Time.now).pluck(:title, :category)
  end
end
