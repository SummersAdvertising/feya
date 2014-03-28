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
		if params[ :year ].nil?
			@entries_grouped = Entry.order( "created_at desc" ).group_by { | e | e.created_at.beginning_of_year }		
		else
			@entries_grouped = Entry.where( :created_at => Time.new(params[ :year ]).at_beginning_of_year..Time.new(params[ :year ]).at_end_of_year ).order( "created_at desc" ).group_by { | e | e.created_at.beginning_of_year }		
		end
	end

end
