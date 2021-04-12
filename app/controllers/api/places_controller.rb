class Api::PlacesController < ApplicationController
  def index
    @places = Places.all
    render "index.json.jb"
  end

  def show
    id_search = params["id"]
    @place = Place.find_by(id: id_search)
    render "show.json.jb"
  end

  def create
    @place = Place.new(
      name: params[:name],
      address: params[:address],
    )
    if @place.save
      render "show.json.jb"
    else
      render json: { errors: @place.errors.full_messages }, status: 406
    end
  end

  def update
    place_id = params["id"]
    @place = Place.find_by(id: place_id)

    @place.name = params[:name] || @place.name
    @place.address = params[:address] || @place.address

    if @place.save
      render "show.json.jb"
    else
      render json: { errors: @place.errors.full_messages }, status: 406
    end
  end

  def destroy
    place_id = params["id"]
    @place = Place.find_by(id: place_id)
    @place.destroy
    render json: { message: "it is gone" }
  end
end
