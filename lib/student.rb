class Student


  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade)
    @name = name
    @grade = grade
    @id = nil
  end

  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (id INTEGER PRIMARY KEY, name TEXT, grade INTEGER);
    SQL

    DB[:conn].execute(sql)
  end


  def self.drop_table
    sql = <<-SQL
    DROP TABLE students
    SQL

    DB[:conn].execute(sql)
  end

  def save
    sql = <<-SQL
    INSERT INTO students (name, grade) VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name,self.grade)

    new_data = <<-SQL
    SELECT * FROM students ORDER BY id DESC LIMIT 1
    SQL

    x = DB[:conn].execute(new_data).flatten

    @id = x[0]

    self
  end


    def self.create(hash)
      new_stud = Student.new(hash[:name],hash[:grade])
      new_stud.save
    end














end
