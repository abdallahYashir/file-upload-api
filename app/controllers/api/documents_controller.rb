class Api::DocumentsController < ApplicationController
  # GET /api/documents
  def index
    documents = Document.all
    render json: documents
  end

  # POST /api/documents
  def create
    document = Document.new(document_params)

    return json: { info: "Document already exists" } if Document.checksum(document.get_checksum).exists?

    if document.save
      render json: document, status: :created
    else
      render json: document.errors, status: :unprocessable_entity
    end
  end

  private

  def document_params
    params.require(:document).permit(:name, :path, :size, :extension, :checksum)
  end
end
