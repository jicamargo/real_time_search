class SearchController < ApplicationController
  def index
    @search_query = params[:query]
    @ip_adrress = request.remote_ip
    #user field is created for future use
    @user ="Guest" 

    SearchStory.create(query: @search_query, ip_address: @ip_adrress, user: @user)

    # @search_results = SearchStory.where("query ILIKE ?", "%#{@search_query}%").pluck(:query)
    # puts @search_results

    respond_to do |format|
      format.html { render :index }
      # format.json { render json: @search_results }
    end
  end

  def get_queries
    @search_query = params[:query]
    @search_results = SearchStory.where("query ILIKE ?", "%#{@search_query}%").pluck(:query)
    puts @search_results
    render json: @search_results
  end
end
