class Api::V1::KudosController < ActionController::API
  # include ActionController::MimeResponds

  def challenge
    render json: params[:challenge]
  end

  def event
    render json: 'Some Event'
  end
end