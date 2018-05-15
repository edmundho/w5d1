class GoalsController < ApplicationController
  def new
    @goal = Goal.new
    @user = User.find(params[:user_id])
    render :new
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = params[:user_id]
    @user = User.find(params[:user_id])

    if @goal.save
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end

  end

  def destroy

  end

  def edit

  end

  def update

  end

  def goal_params
    params.require(:goal).permit(:title)
  end

end
