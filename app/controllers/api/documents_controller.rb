class Api::DocumentsController < ApplicationController
  # GET /api/documents
  def index
    documents = Document.all
    render json: documents
  end

  # POST /api/documents
  def create
    return if params[:file].nil?

    permitted_params = document_params
    document = Document.new(permitted_params[:file])

    return render json: { info: 'Document already exists' } if Document.find_by(checksum: document.checksum)

    if document.save!
      render json: document, status: :created
    else
      render json: document.errors, status: :unprocessable_entity
    end
  end

  private

  def document_params
    params.permit( :file)
  end
end
