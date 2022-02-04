class SpicesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_response

    # GET /spices
    def index
        render json: Spice.all
    end

    # POST /spices
    def create
        new_spice = Spice.create!(spice_params)
        render json: new_spice, status: 201
    end

    # PATCH /spices/:id
    def update
        update_spice = find_spice
        update_spice.update!(spice_params)
        render json: update_spice, status: 200
    end

    # DESTROY /spices/:id
    def destroy
        delete_spice = find_spice
        delete_spice.destroy
        head :no_content
    end

    private

    def spice_params
        params.permit(:title, :image, :description, :notes, :rating)
    end

    def find_spice
        Spice.find(params[:id])
    end

    def render_not_found_response(err)
        render json: { error: err.record.messages.full_messages }, status: 404
    end

    def render_invalid_response(err)
        render json: { error: err.record.messages.full_messages }, status: 422
    end
end
