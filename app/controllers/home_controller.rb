class HomeController < ApplicationController
  def index
    @data_sets = HTTParty.get('http://api.us.socrata.com/api/catalog/v1?domains=data.nashville.gov')
  end
end
