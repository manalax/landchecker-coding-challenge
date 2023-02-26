# frozen_string_literal: true

class Api::V1::LgasController < ApplicationController
  before_action :find_lga, only: [:show, :update, :destroy]
  after_action { pagy_headers_merge(@pagy) if @pagy }

  def index
    @pagy, @lgas = pagy(Lga.all, items: 5)
    render json: { data: @lgas, metadata: pagy_metadata(@pagy) }
  end

  def show
    find_lga
    render json: @lga
  end

  def create
    @lga = Lga.new(lga_params)
    if @lga.save
      render json: @lga
    else
      render error: { error: 'Unable to create LGA.' }, status: 400
    end
  end

  def update
    find_lga
    if @lga
      @lga.update(lga_params)
      render json: { message: "LGA #{params[:id]} successfully updated" }, status: 200
    else
      render json: { error: 'Unable to update LGA' }, status: 400
    end
  end

  def destroy
    find_lga
    if @lga
      @lga.destroy
      render json: { message: "LGA #{params[:id]} successfully deleted" }, status: 200
    else
      render json: { error: 'Unable to delete LGA' }, status: 400
    end
  end

  private

  def lga_params
    params.require(:lga).permit(:property_id, :council_property_number, :full_address, :latitude, :longitude,
                                :postcode)
  end

  def find_lga
    render json: { error: "ID #{params[:id]} is not an integer" }, status: 400 and return unless is_integer(params[:id])
    begin
      @lga = Lga.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Unable to find LGA with id #{params[:id]}" }, status: 404
    end 
  end

  # taken from https://stackoverflow.com/questions/1235863/how-to-test-if-a-string-is-basically-an-integer-in-quotes-using-ruby
  def is_integer(str)
    return !!(str =~ /\A[-+]?[0-9]+\z/)
  end
end
