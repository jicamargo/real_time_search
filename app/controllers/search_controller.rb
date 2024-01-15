class SearchController < ApplicationController
  before_action :assign_user_name, only: [:index]

  def index
    respond_to do |format|
      format.html { render :index }
      # format.json { render json: @search_results }
    end
  end

  def get_queries
    @search_query = params[:query]
    @ip_address = request.remote_ip
    assign_user_name
    existing_story = SearchStory.find_by(ip_address: @ip_address, user_name: @user_name, query: @search_query)

    if existing_story
      existing_story.increment!(:counter)
    else
        SearchStory.create(query: @search_query, ip_address: @ip_address, user_name: @user_name)
    end

    delete_incomplete_querie(@user_name, @search_query)

    @search_query = params[:query]
    @search_results = SearchStory.where(ip_address: @ip_address).where("query ILIKE ?", "%#{@search_query}%").pluck(:query)
    render json: @search_results
  end
  
  def delete_incomplete_querie(user_name, search_query)
    # delete the last word from the array
    query_words = search_query.strip.split(' ')
    # Delete incomplete queries from the beginning to the second-to-last word
    (0..query_words.length - 2).each do |i|
      incomplete_query = query_words[0..i].join(' ')
      SearchStory.where(user_name: user_name, query: incomplete_query).delete_all
    end
  end

  def reset
    assign_user_name
    SearchStory.where(user_name: @user_name).delete_all
    redirect_to root_path
  end

  private

  def assign_user_name
    # assign user_name based on IP, use session for persistence
    user_ip = request.remote_ip
    @user_name = session[:user_name] || "Guest-#{user_ip}"
    session[:user_name] = @user_name
  end
end