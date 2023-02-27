# frozen_string_literal: true

# user Class
require 'json'
require '/Users/apple/QuizSystem/App/quiz_questions'
require '/Users/apple/QuizSystem/App/driver'
class User
  attr_accessor :first_name, :last_name, :user_role, :email, :password

  def initialize() end

  def as_json(_options = {})
    {
      first_name: @first_name,
      last_name: @last_name,
      user_role: @user_role,
      email: @email,
      password: @password
    }
  end

  def to_json(*options)
    as_json(*options).to_json(*options)
  end

  def create_user(first_name, last_name, email, password)
    user = User.new
    user.first_name = first_name
    user.last_name = last_name
    user.user_role = user_role
    user.email = email
    user.password = password
    puts user.to_json
    save_user(user)
  end

  def save_user(user)
    file = File.open('user.json', 'a+') { |f| f << "#{user.to_json}\n" }
    file.close
  end

  def find_user
    # File.open('user.txt', 'r').read
    filebuffer = File.open('user.json', 'r').read
    filedata = filebuffer.split("\n")
    filedata.map { |line| JSON.parse(line, object_class: OpenStruct) }
  end

  def continue_teacher
    driver = Driver.new
    puts 'press any key to return'
    gets
    driver.teacher_menu
  end

  def continue_student
    driver = Driver.new
    puts 'press any key to return'
    gets
    driver.student_menu
  end

  def sign_up
    puts 'Please enter your first_name: '
    @first_name = gets
    puts 'Please enter your last_name: '
    @last_name = gets
    puts 'Please enter your role: '
    @user_role = gets
    puts 'Please enter your email: '
    @email = gets
    puts 'Please enter your password: '
    @password = gets
    puts 'Please confirm your password: '
    password_confirm = gets
    if password == password_confirm
      create_user(@first_name, @last_name, @email, password)
      puts 'User created successfully'
    else
      puts 'Passwords do not match'
    end
  end
end
