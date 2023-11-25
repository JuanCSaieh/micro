class UsersController < ApplicationController
	before_action :set_user, only: %i[update destroy]

	def index
		@users = User.all
		render json: @users
	end

	def create
		@user = User.new(user_params)
		if @user.save!
			Log.create!(user_params.merge(opType: :crear,
										created_at: Date.today))
			render json: @user
		else
			render status: 400
		end
	end

	def show
		@user = User.find_by(docType: params[:docType],
							docNum: params[:docNum])
		if @user
			render json: @user
		else
			render status: 400
		end
	end

	def update
		if @user.update(user_params)
			log_params = @user.attributes.except("id",
											"created_at", "updated_at")
			Log.create!(log_params.merge(opType: :modif))
	      	render json: @user
	    else
      		render status: 400
	    end
	end

	def destroy
		if @user.destroy
			log_params = @user.attributes.except("id",
											"created_at", "updated_at")
			Log.create!(log_params.merge(opType: :elim))
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
