class LogsController < ApplicationController
	before_action :log_params, only: :create

	def index
		@logs = Log.all
		render json: @logs
	end

	def create
		@logs = Log.where(log_params)
		render json: @logs
	end

	protected

	def log_params
		params.require(:log).permit(:docType, :docNum,
									:created_at)
	end
end
