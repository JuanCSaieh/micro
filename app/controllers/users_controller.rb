class UsersController < ApplicationController
	before_action :set_user, only: %i[update destroy]

	def index
		@users = User.all
		render json: @users
	end

	def create
		req_params = {}
		9.times { |i| req_params[user_params.keys[i]] = user_params.values[i] }

		@user = User.new(req_params)
		if @user.save!
			Log.create!(req_params.merge(opType: :crear,
										created_at: Date.today))
			render json: @user
		else
			render status: 400
		end
	end

	def show
		@user = User.find_by(docType: params[:docType],
							docNum: params[:docNum])
		if @user.valid?
			render json: @user.id
		else
			render status: 400
		end
	end

	def update
		if @user.update!(user_params)
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
		params.permit(:docType,
				:docNum, :firstName, :secondName, :lastName,
				:dateBirth, :gender, :email, :phoneNumber)
	end

	def user_params_update
		params.permit(:_json, :docType, :docNum, :firstName,
				:secondName, :lastName, :dateBirth, :gender,
				:email, :phoneNumber)[:_json]
	end

	def set_user
		@user = User.find(params[:id])
	end
end
