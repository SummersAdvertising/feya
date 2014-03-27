class EntriesController < ApplicationController
	
	before_filter :get_grouped_entries

	def index
	end

	def show
		@entry = Entry.find( params[ :id ] )
	end

private
	def get_grouped_entries
		@entries = Entry.order( "created_at desc" )
		@entries_grouped = Entry.order( "created_at desc" ).group_by { | e | e.created_at.beginning_of_year }		
	end

end
