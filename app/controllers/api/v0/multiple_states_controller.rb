class Api::V0::MultipleStatesController < ApplicationController
  def index
    vendors = Vendor.all
    multiple_states = vendors.multiple_states

    if multiple_states.present?
      render json: VendorSerializer.new(multiple_states)
    else
      render json: { errors: [{ detail: "No Vendors with Multiple States Found" }] }, status: :not_found
    end
  end
end