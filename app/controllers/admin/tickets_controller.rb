class Admin::TicketsController < AdminController
	def index
		@tickets = Ticket.order('created_at DESC').page( params[ :page ] ).per( 20 )
	end
	
	def show
		@ticket = Ticket.find( params[ :id ] )
		
		
		
	end
	
end
