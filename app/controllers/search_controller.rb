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
    @user_name ="Guest"  #created for future use

    existing_story = SearchStory.find_by(ip_address: @ip_address, user_name: @user_name, query: @search_query)

    if existing_story
      existing_story.increment!(:counter)
    else
        SearchStory.create(query: @search_query, ip_address: @ip_address, user_name: @user_name)
    end

    delete_incomplete_querie(@ip_address, @user_name, @search_query)

    @search_query = params[:query]
    @search_results = SearchStory.where(ip_address: @ip_address).where("query ILIKE ?", "%#{@search_query}%").pluck(:query)
    render json: @search_results
  end
  
  def delete_incomplete_querie(ip_address, user_name, search_query)
    queries = SearchStory
      .where(ip_address: ip_address, user_name: user_name)
      .where("query ILIKE ?", "#{@search_query}%")
      .pluck(:query)

    # delete the last word from the array
    query_words = search_query.strip.split(' ')
    query_words.pop
    incomplete_querie = query_words.join(' ')

    SearchStory.where(ip_address: ip_address, query: incomplete_querie).delete_all
  end

  def reset
    @ip_address = request.remote_ip
    SearchStory.where(ip_address: @ip_address).delete_all
    redirect_to root_path
  end

end
