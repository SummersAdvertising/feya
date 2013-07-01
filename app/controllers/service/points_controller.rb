class Service::PointsController < ApplicationController
	before_filter :is_member
	layout "service"
end