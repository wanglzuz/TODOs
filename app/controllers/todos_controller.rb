class TodosController < ApplicationController
  before_action :user_authentication

  def index

    @todos = @user.todos
    status = params[:status]

    if @todos == nil
      render json: {message: "No TODOs to show."}, status: 200
      return
    elsif status == nil
      render json: @todos, status: 200
      return
    elsif status == "ongoing"
      @todos = @todos.where(done: false)
      render json: @todos, status: 200
      return
    elsif status == "done"
      @todos = @todos.where(done: true)
      render json: @todos, status: 200
      return
    else
      render json: {error_message: "Invalid status!"}, status: 404
      return
    end


  end

  def show

    @todo = Todo.find_by(id: params[:id])

    if @todo == nil
      render json: {error_message: "TODO with this ID does not exist!"}, status: 404
      return
    elsif @todo.user != @user
      render json: {error_message: "This TODO does not belong to you!"}, status: 403
      return
    else
      render json: @todo, status: 200
      return
    end

  end

  def create

  end

  def update

  end

  def done

  end

  def destroy

  end

private

  def user_authentication

    access_token = request.headers["HTTP_ACCESS_TOKEN"]

    if access_token == nil
      render json: {error_message: "No access token provided!"}, status: 401
      return
    end

    @user = User.find_by(access_token: access_token)
    if @user == nil
      render json: {error_message: "Invalid access token!"}, status: 401
      return
    end


  end

end
