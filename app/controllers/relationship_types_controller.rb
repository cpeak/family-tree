class RelationshipTypesController < ApplicationController
  def index
    @relationship_types = RelationshipType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @relationship_types }
    end
  end

  def show
    @relationship_type = RelationshipType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @relationship_type }
    end
  end

  def new
    @relationship_type = RelationshipType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @relationship_type }
    end
  end

  def edit
    @relationship_type = RelationshipType.find(params[:id])
  end

  def create
    @relationship_type = RelationshipType.new(params[:relationship_type])

    respond_to do |format|
      if @relationship_type.save
        format.html { redirect_to @relationship_type, notice: 'Relationship type was successfully created.' }
        format.json { render json: @relationship_type, status: :created, location: @relationship_type }
      else
        format.html { render action: "new" }
        format.json { render json: @relationship_type.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @relationship_type = RelationshipType.find(params[:id])

    respond_to do |format|
      if @relationship_type.update_attributes(params[:relationship_type])
        format.html { redirect_to @relationship_type, notice: 'Relationship type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @relationship_type.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @relationship_type = RelationshipType.find(params[:id])
    @relationship_type.destroy

    respond_to do |format|
      format.html { redirect_to relationship_types_url }
      format.json { head :no_content }
    end
  end
end
