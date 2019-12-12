# frozen_string_literal: true

class LocationsController < ApplicationController
  before_action :set_location, only: %i[show edit update destroy]
  include ApplicationHelper
  # GET /locations
  # GET /locations.json
  def index
    @locations = Location.all
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
    if valid_location(@location)
      @buses = HTTParty.get('http://developer.itsmarta.com/BRDRestService/RestBusRealTimeService/GetAllBus')

      @bus_count = @buses.length

      @nearby_buses = []

      @buses.each do |bus|
        #if the bus is nearby then add it to the list of nearby_buses 
        if nearby(@location.longitude, @location.latitude, bus['LONGITUDE'].to_f, bus['LATITUDE'].to_f)
          @nearby_buses.push({
            :longitude => bus['LONGITUDE'],
            :latitude => bus['LATITUDE'],
            :address => bus['TIMEPOINT'],
            :title => bus['VEHICLE'] + " going " + bus['DIRECTION']
            })
        end
      end
    else 
      redirect_to root_path, notice: "It bombed!"
    end
  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit; end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(location_params)

    respond_to do |format|
      if @location.save
        format.html { redirect_to @location, notice: 'Location was successfully created.' }
        format.json { render :show, status: :created, location: @location }
      else
        format.html { render :new }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { render :show, status: :ok, location: @location }
      else
        format.html { render :edit }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location.destroy
    respond_to do |format|
      format.html { redirect_to locations_url, notice: 'Location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_location
    @location = Location.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def location_params
    params.require(:location).permit(:address, :city, :latitude, :longitude)
  end
end
