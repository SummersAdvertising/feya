# encoding: utf-8
class TicketsController < ApplicationController
	def new
		@ticket = Ticket.new	
	end
	
	def create
		@ticket = Ticket.new( params[ :ticket ] )
		
		respond_to do | format |	
			if @ticket.save
				format.html { redirect_to new_ticket_path, notice: '謝謝您的詢問，我們將儘快回覆您！' }
			else
				flash[ :warning ] = @ticket.errors.messages.values.flatten.join('<br>')
				format.html { render :new }
			end
		end
		
	end
	
end
