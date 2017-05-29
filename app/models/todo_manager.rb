class TodoManager

  def initialize (todo)
    @todo = todo
  end

  # Cekal bych, ze ti to bude todo vracet, potom co ho upravis.
  # Uzivatel teto metody si jinak neni jisty, jestli zmena probehla in-place (todo co predal do metody je done nebo ne)
  def mark_done!

    @todo.done = true
    @todo.save!
    return @todo

  end

  # Cekal bych, ze ti to bude todo vracet, potom co ho upravis.
  # Uzivatel teto metody si jinak neni jisty, jestli zmena probehla in-place (todo co predal do metody ma upraveny text nebo ne)
  def edit_text!(text)

    @todo.text = text
    @todo.save!
    return @todo

  end

  #tady bychom asi normalne pojmenovali metodu bez vykricniku, protoze se da cekat, ze created object bude i saved. Kdybychom chteli naznacit ze navracene todo nebude saved, pouzili bychom slovo build. (build_todo)
  def self.create_todo(text, user)
    todo = Todo.create!({text: text, created: DateTime.now, done: false, user: user})
    todo.save!
    return todo

  end

  def delete!
    @todo.destroy!
    return
  end



end
