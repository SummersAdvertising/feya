# encoding: utf-8
class Admin::TicketsController < AdminController
	def index
		@tickets = Ticket.order('created_at DESC').page( params[ :page ] ).per( 20 )
	end
	
	def show
		@ticket = Ticket.find( params[ :id ] )
		
		
		
	end
	
	def destroy
		@ticket = Ticket.find( params[ :id ] )
		
		@ticket.destroy
		
		respond_to do | format |
			format.html { redirect_to admin_tickets_path, notice: "成功刪除該筆資訊" }
		end
		
	end
	
end
