class Service::AddressbooksController < ApplicationController
	before_filter :is_member
	layout "service"

	def index
		@addresses = Addressbook.where(["member_id = ?", current_member.id])
		@address = Addressbook.new
	end

	def create
		@address = Addressbook.new(params[:addressbook])
		@address.member_id = current_member.id

		respond_to do |format|
			if @address.save
				format.html { redirect_to  service_addressbooks_path }
				format.json { render json: @address, status: :created, location: @address }
			else
				@addresses = Addressbook.where(["member_id = ?", current_member.id])

				format.html { render action: "index" }
				format.json { render json: @address.errors, status: :unprocessable_entity }
			end
		end
		
	end

	def destroy
		@address = Addressbook.find(params[:id])
		@address.destroy

		respond_to do |format|
			format.html { redirect_to  service_addressbooks_path }
			format.json { render json: @address }
		end
		
	end
	
end