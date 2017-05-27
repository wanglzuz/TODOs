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

  def self.create_todo!(text, user)
    todo = Todo.create!({text: text, created: DateTime.now, done: false, user: user})
    todo.save!
    return todo

  end



end
