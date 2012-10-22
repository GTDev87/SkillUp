class MissionEmbeddingsController < ApplicationController
  # GET /mission_embeddings
  # GET /mission_embeddings.json
  def index
    @mission_embeddings = MissionEmbedding.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @mission_embeddings }
    end
  end

  # GET /mission_embeddings/1
  # GET /mission_embeddings/1.json
  def show
    @mission_embedding = MissionEmbedding.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @mission_embedding }
    end
  end

  # GET /mission_embeddings/new
  # GET /mission_embeddings/new.json
  def new
    @mission_embedding = MissionEmbedding.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @mission_embedding }
    end
  end

  # GET /mission_embeddings/1/edit
  def edit
    @mission_embedding = MissionEmbedding.find(params[:id])
  end

  # POST /mission_embeddings
  # POST /mission_embeddings.json
  def create
    @mission_embedding = MissionEmbedding.new(params[:mission_embedding])

    respond_to do |format|
      if @mission_embedding.save
        format.html { redirect_to @mission_embedding, notice: 'Mission embedding was successfully created.' }
        format.json { render json: @mission_embedding, status: :created, location: @mission_embedding }
      else
        format.html { render action: "new" }
        format.json { render json: @mission_embedding.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /mission_embeddings/1
  # PUT /mission_embeddings/1.json
  def update
    @mission_embedding = MissionEmbedding.find(params[:id])

    respond_to do |format|
      if @mission_embedding.update_attributes(params[:mission_embedding])
        format.html { redirect_to @mission_embedding, notice: 'Mission embedding was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @mission_embedding.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mission_embeddings/1
  # DELETE /mission_embeddings/1.json
  def destroy
    @mission_embedding = MissionEmbedding.find(params[:id])
    @mission_embedding.destroy

    respond_to do |format|
      format.html { redirect_to mission_embeddings_url }
      format.json { head :no_content }
    end
  end
end
