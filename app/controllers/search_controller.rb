class SearchController < ApplicationController
  def index
    @search_query = params[:query]
    @ip_adrress = request.remote_ip
    #user field is created for future use
    @user ="Guest" 
    SearchStory.create(query: @search_query, ip_address: @ip_adrress, user: @user)
  end
end
