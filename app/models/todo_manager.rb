class TodoManager

  def initialize (todo)
    @todo = todo
  end

  def mark_done!

    @todo.done = true
    return

  end



end