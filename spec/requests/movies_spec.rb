require 'rails_helper'

RSpec.describe "Movies", type: :request do
  describe "GET /index" do
    context "when query query_param is missing" do
      it "is expected to be a bad request" do
        get movies_path

        expect(response).to have_http_status :bad_request
      end

      it "is expected to have error message" do
        get movies_path

        expect(response.parsed_body).to include({ "error": "query query_param is missing" })
      end
    end

    context "when query query_param is present" do
      before do
        allow(TMDB::APIClient).to receive(:search_movie).and_return(
          {
            success: true,
            data: { title: "Iron Man" }
          }
        )
      end

      it 'returns a successful response' do
        get movies_path, params: { query: "Iron Man" }

        expect(response).to have_http_status :ok
      end

      it 'returns the result in response body' do
        get movies_path, params: { query: "Iron Man" }

        expect(response.parsed_body).to include(
          { "data" => { "title" => "Iron Man" } }
        )
      end
    end
  end
end
