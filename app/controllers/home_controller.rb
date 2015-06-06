class HomeController < ApplicationController
  def index
    api_data = HTTParty.get('https://data.nashville.gov/data.json')
    api_data['dataset'].each do |data|
      Dataset.where(:identifier=>data['identifier']).first_or_create(
        :date_created=>data['issued'],
        :date_updated=>data['modified'],
        :title=>data['title']
      )
    end
    @chart_data = Dataset.pluck(:title, :date_created, :date_updated)
  end
end
