class HonoluluController < ApplicationController
  def index
    honolulu_api_data = HTTParty.get('https://data.honolulu.gov/data.json')
      honolulu_api_data['dataset'].each do |data|
        Dataset.where(:identifier=>data['identifier']).first_or_create(
          :date_created=>data['issued'],
          :date_updated=>data['modified'],
          :title=>data['title']
        )
      end
      @honolulu_chart_data = Dataset.where("identifier like '%honolulu%'").pluck(:title, :date_created, :date_updated)
      @honolulu_count = Dataset.where("identifier like '%honolulu%'").count
  end
end
