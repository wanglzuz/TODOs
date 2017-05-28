class TodosController < ApplicationController
  include Authable

  def index

    @todos = @user.todos
    status = params[:status]
    # Tohle je nake zmatecne zbytecne hodne se opakujes. Jak by se to dalo napsat tak, aby ses neopakovala? (hint: mela bys mit jenom jeden render pro success (ne 4) a jeden render pro error) (hint @user.todos, se bude vzdy minimalne [], nikdy nebude nil)
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

    if find_todo_with_id(params[:id])
      render json: @todo, status: 200, serializer: TodoSerializer
    end

  end

  def create

    todo = TodoManager.create_todo!(params[:text], @user)
    render json: todo, status: 201, serializer: TodoSerializer

  end

  def update

    if find_todo_with_id(params[:id])
      TodoManager.new(@todo).edit_text!(params[:text])
      render json: @todo, status: 200, serializer: TodoSerializer
    end

  end

  def done

    if find_todo_with_id(params[:id])
      #chvalim za vykricnikove metody v tomto kontextu
      TodoManager.new(@todo).mark_done!
      render json: @todo, status: 200, serializer: TodoSerializer
    end

  end

  def destroy
    if find_todo_with_id(params[:id])
      TodoManager.new(@todo).delete!
      render json: {}, status: 200
    end

  end

private

  def find_todo_with_id (id)

    @todo = Todo.find_by(id: id)
    unless @todo == nil or @todo.user == @user
      @todo = nil
    end
    if @todo == nil
      render json: {error_message: "TODO with this ID does not exist!", code: "NOT_FOUND"}, status: 404
      return false
    end
    return true
  end




end
