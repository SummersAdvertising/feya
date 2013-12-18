class Service::AddressbooksController < ApplicationController
	before_filter :is_member
	layout "service"

	def index
		@addresses = current_member.addressbooks
		@address = Addressbook.new
	end

	def create
		@address = current_member.addressbooks.new(params[:addressbook])

		respond_to do |format|
			if (@address.save)
				format.html { redirect_to  service_addressbooks_path }
				format.json { render json: @address, status: :created, location: @address }
			else
				flash[ :warning ] = @addresses.errors.messages.values.flatten.join('<br>')
			
				@addresses = Addressbook.where(:member_id => current_member.id).all

				format.html { render action: "index" }
				format.json { render json: @address.errors, status: :unprocessable_entity }
			end
		end
		
	end

	def destroy
		@address = current_member.addressbooks.find(params[:id])
		@address.destroy

		respond_to do |format|
			format.html { redirect_to  service_addressbooks_path }
			format.json { render json: @address }
		end
		
	end
	
end