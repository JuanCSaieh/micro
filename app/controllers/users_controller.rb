class UsersController < ApplicationController
	before_action :set_user, only: %i[update destroy]

	def index
		@users = User.all
		render json: @users
	end

	def create
		@user = User.new(user_params)
		if @user.save!
			# TODO create logs
			render json: @user
		else
			render status: 400
		end
	end

	def show
		@user = User.find_by(docType: params[:docType],
							docNum: params[:docNum])

		if @user
			# TODO create logs
			render json:@user
		else
			render status: 400
		end
	end

	def update
		#@user = User.find(params[:id])
		if @user.update(user_params)
			# TODO create logs
	      	render json: @user
	    else
      		render status: 400
	    end
	end

	def destroy
		#@user = User.find(params[:id])
		if @user.destroy
			# TODO create logs
			render status: 200, json: @controller.to_json
		else
			render status: 400
		end
	end

	protected

	def user_params
		params.require(:user).permit(:docType,
				:docNum, :firstName, :secondName, :lastName,
				:dateBirth, :gender, :email, :phoneNumber)
	end

	def set_user
		@user = User.find(params[:id])
	end
end
