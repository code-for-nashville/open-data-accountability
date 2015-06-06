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
    nashville_data = Dataset.where("identifier like '%nashville%'")
    @nash_chart_data = nashville_data.pluck(:title, :date_created, :date_updated)
    @nash_count = nashville_data.count
    @created_this_month = nashville_data.where(:date_created => 1.month.ago..Time.now).pluck(:title, :category)
    @updated_this_month = nashville_data.where(:date_updated => 1.month.ago..Time.now).pluck(:title, :category)
  end
end
