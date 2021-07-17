class ApplicationController < ActionController::Base
  def respond_with(json)
    respond_to do |format|
      format.json { render json: {message: 'SUCCESS', data: json, code: 20} }
    end
  end

  def respond_with_error(error_message, error_code)
    respond_to do |format|
      format.json { render json: {message: error_message, code: error_code}}
    end
  end
end
