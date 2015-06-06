class HonoluluController < ApplicationController
  def index
    honolulu_api_data = HTTParty.get('https://data.honolulu.gov/data.json')
      honolulu_api_data['dataset'].each do |data|
        Dataset.where(:identifier=>data['identifier']).first_or_create(
          :date_created=>data['issued'],
          :date_updated=>data['modified'],
          :category=>data['landingPage'],
          :title=>data['title']
        )
      end
      honolulu_data = Dataset.where("identifier like '%honolulu%'")
      @honolulu_chart_data = honolulu_data.pluck(:title, :date_created, :date_updated)
      @honolulu_count = honolulu_data.count
      @created_this_month = honolulu_data.where(:date_created => 1.month.ago..Time.now).pluck(:title, :category)
      @updated_this_month = honolulu_data.where(:date_updated => 1.month.ago..Time.now).pluck(:title, :category)
  end
end
