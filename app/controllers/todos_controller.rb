class TodosController < ApplicationController

  def index

    @todos = @user.todos
    status = params[:status]

    if @todos == nil
      render json: [], status: 200
      return
    elsif status == nil
      render json: @todos, status: 200, each_serializer: TodoInfoSerializer
      return
    elsif status == "ongoing"
      @todos = @todos.where(done: false)
      render json: @todos, status: 200, each_serializer: TodoInfoSerializer
      return
    elsif status == "done"
      @todos = @todos.where(done: true)
      render json: @todos, status: 200, each_serializer: TodoInfoSerializer
      return
    else
      render json: {error_message: "Invalid status!", code: "INVALID_STATUS"}, status: 404
      return
    end


  end

  def show

    @todo = Todo.find_by(id: params[:id])

    if (@todo == nil) or (@todo.user != @user)
      render json: {error_message: "TODO with this ID does not exist!", code: "NOT_FOUND"}, status: 404
      return
    else
      render json: @todo, status: 200, serializer: TodoSerializer
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


end
