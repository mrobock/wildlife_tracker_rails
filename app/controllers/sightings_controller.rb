class SightingsController < ApplicationController
  before_action :set_sighting, only: [:show, :edit, :update, :destroy]
  before_action :set_regions, only: [:index, :new]

  # GET /sightings
  # GET /sightings.json
  def index
    if (params[:start_date].nil? && params[:end_date].nil?) || (params[:start_date].empty? && params[:end_date].empty?)
      @sightings = Sighting.all
    else
      @sightings = Sighting.where(
        sighting_time: params[:start_date]..params[:end_date],
        region: params[:region]
      )
    end
  end

  # GET /sightings/1
  # GET /sightings/1.json
  def show
  end

  # GET /sightings/new
  def new
    #create new blank sighting
    @sighting = Sighting.new

    #if new sighting url contains animal id params already (i.e. routed from animal page)
    if !params[:animal_id].nil? && !params[:animal_id].strip.empty?
      @sighting.animal = Animal.find(params[:animal_id])
    end

    #Set up the animals for dropdown list
    @animals_for_select = Animal.all.map do |animal|
      [animal.c_name, animal.id]
    end
  end

  # GET /sightings/1/edit
  def edit
  end

  # POST /sightings
  # POST /sightings.json
  def create
    @sighting = Sighting.new(sighting_params)

    respond_to do |format|
      if @sighting.save
        format.html { redirect_to @sighting, notice: 'Sighting was successfully created.' }
        format.json { render :show, status: :created, location: @sighting }
      else
        format.html { render :new }
        format.json { render json: @sighting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sightings/1
  # PATCH/PUT /sightings/1.json
  def update
    respond_to do |format|
      if @sighting.update(sighting_params)
        format.html { redirect_to @sighting, notice: 'Sighting was successfully updated.' }
        format.json { render :show, status: :ok, location: @sighting }
      else
        format.html { render :edit }
        format.json { render json: @sighting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sightings/1
  # DELETE /sightings/1.json
  def destroy
    @sighting.destroy
    respond_to do |format|
      format.html { redirect_to sightings_url, notice: 'Sighting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sighting
      @sighting = Sighting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sighting_params
      params.require(:sighting).permit(:sighting_time, :latitude, :longitude, :animal_id, :region)
    end

    def set_regions
      @regions_for_select = [['North', 'North'], ['South','South'], ['East', 'East'], ['West', 'West']]
    end
end
