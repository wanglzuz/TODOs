class TodoManager

  def initialize (todo)
    @todo = todo
  end

  def mark_done!

    @todo.done = true
    @todo.save!
    return

  end

  def edit_text!(text)

    @todo.text = text
    @todo.save!
    return

  end



end