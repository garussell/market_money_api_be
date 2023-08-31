class Api::V0::VendorsController < ApplicationController
  def index
    begin
      market = Market.find(params[:market_id])
      vendors = market.vendors
      render json: VendorSerializer.new(vendors)
    rescue
      render json: { errors: [{ detail: "Couldn't find Market with 'id'=#{params[:market_id]}"}]}, status: :not_found
    end
  end

  def show
    begin
      render json: VendorSerializer.new(Vendor.find(params[:id]))
    rescue ActiveRecord::RecordNotFound
      render json: { errors: [{ detail: "Couldn't find Vendor with 'id'=#{params[:id]}"}] }, status: :not_found
    end
  end  

  def create
    begin
      vendor = Vendor.create!(vendor_params)
      render json: VendorSerializer.new(vendor), status: :created
    rescue ActiveRecord::RecordInvalid => e
      render json: { errors: [{ detail: e.record.errors.full_messages }]}, status: :bad_request
    end
  end

  def update
   begin
    vendor = Vendor.find(params[:id])

    if vendor.update(vendor_params)
      render json: VendorSerializer.new(vendor), status: :ok
    else
      render json: { errors: [{ detail: vendor.errors.full_messages }]}, status: :unprocessable_entity
    end
    
    rescue ActiveRecord::RecordNotFound
      render json: { errors: [{ detail: "Couldn't find Vendor with 'id'=#{params[:id]}"}] }, status: :not_found
    end
  end

  def destroy
    begin
      vendor = Vendor.find(params[:id])
      vendor.destroy
      head :no_content
    rescue ActiveRecord::RecordNotFound
      render json: { errors: [{ detail: "Couldn't find Vendor with 'id'=#{params[:id]}"}] }, status: :not_found
    end
  end
  
  private

  def vendor_params
    params.require(:vendor).permit(:name, :description, :contact_name, :contact_phone, :credit_accepted)
  end
end