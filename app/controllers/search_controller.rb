class SearchController < ApplicationController
  def index

    respond_to do |format|
      format.html { render :index }
      # format.json { render json: @search_results }
    end
  end

  def get_queries
    @search_query = params[:query]
    @ip_address = request.remote_ip
    #user field is created for future use
    @user ="Guest" 
    SearchStory.create(query: @search_query, ip_address: @ip_address, user: @user)

    @search_query = params[:query]
    @search_results = SearchStory.where("query ILIKE ?", "%#{@search_query}%").pluck(:query)
    puts @search_results
    render json: @search_results
  end
end
