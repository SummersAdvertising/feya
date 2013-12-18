class Admin::TicketsController < AdminController
	def index
		@tickets = Ticket.page( params[ :page ] ).per( 20 )
	end
	
	def show
		@ticket = Ticket.find( params[ :id ] )
		
		
		
	end
	
end
