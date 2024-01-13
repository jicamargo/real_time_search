class AnalyticsController < ApplicationController
  helper_method :day_of_week

  def index
    @analytics_data = SearchStory.
      group(:user_name, :ip_address, :query).
      select('user_name, ip_address, query, sum(counter) as total_queries')
      .order(:user_name, :ip_address, 'total_queries DESC')

    @user_queries = SearchStory
      .group(:user_name)
      .select('user_name, sum(counter) as total_queries')
      .order('total_queries DESC')

    @day_of_week_queries = SearchStory
      .group("EXTRACT(DOW FROM created_at)")
      .select('EXTRACT(DOW FROM created_at) as day_of_week, SUM(counter) as total_queries')
      .order('total_queries DESC')

      @popular_words = SearchStory
      .select('query')
      .map(&:query)
      .flat_map { |query| query.split(/\W+/) }
      .reject { |word| %w[what how is are a an the].include?(word.downcase) }
      .group_by(&:downcase)
      .transform_values(&:count)
      .sort_by { |word, count| [-count, word] }
      .first(20)
  end

  def day_of_week(day_number)
    Date::DAYNAMES[day_number]
  end
end