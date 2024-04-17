class ApplicationController < ActionController::API
  rescue_from ActionController::BadRequest, with: :bad_request

  private

  def bad_request(exception)
    render json: { "error": exception.message }, status: :bad_request
  end
end
