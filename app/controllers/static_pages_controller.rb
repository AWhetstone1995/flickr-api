class StaticPagesController < ApplicationController
  require 'flickr'

  def index
    flickr = Flickr.new
    @photos = flickr.photos.getRecent(:api_key => ENV['FLICKR_API_KEY'])
    if params[:flickr_id]
      begin
        @photos = flickr.people.getPublicPhotos(:user_id => params[:flickr_id], :api_key => ENV['FLICKR_API_KEY'])
      rescue Flickr::FailedResponse
        flash[:notice] = "That user does not exist"
      end
    end
  end
end
