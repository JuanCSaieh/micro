class UsersController < ApplicationController
	def index
		@user = User.all
		render json: @user
	end

	def new
		@user = User.new
		render json: @user
	end

	def create
		@user = User.new(params[:user])
		render json: @user.save!(user_params)
	end

	def show # search by docType and docNum!
	end

	def delete # search by docType and docNum!
	end

	def user_params
		params.require(:user).permit(:docTypeoc,
				:docNum, :firstName, :secondName, :lastName,
				:dateBirth, :gender, :email, :phoneNumber)
	end
	
	# search by docType and docNum!
	#def set_user
	#	@user = User.find(params[:id])
	#end
end
