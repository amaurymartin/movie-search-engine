require "net/http"

module TMDB
  class APIClient
    BASE_URL = "https://api.themoviedb.org/3"
    API_KEY = ENV.fetch("API_KEY")

    def self.search_movie(query_params)
      uri = URI(BASE_URL.concat("/search/movie"))

      params = query_params.merge({ "api_key": API_KEY })
      uri.query = URI.encode_www_form(params)

      res = Net::HTTP.get_response(uri)

      { success: res.is_a?(Net::HTTPSuccess), data: res.body }
    end
  end
end
