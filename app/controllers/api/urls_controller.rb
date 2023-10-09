module Api
  class UrlsController < ApplicationController
    before_action :authenticate_user!, only: [:shorten, :original_url]

    def shorten
      url = Url.new(original_url: params[:original_url])

      if url.save
        render json: { short_url: url.short_url }, status: :created
      else
        render json: { errors: url.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def original_url
      url = Url.find_by(short_url: params[:short_url])

      if url
        url = Url.find_by(short_url: params[:short_url])
        render json: { original_url: url.original_url }, status: :ok
      else
        render json: { error: 'Short URL not found' }, status: :not_found
      end
    end
  end
end
