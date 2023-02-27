# frozen_string_literal: true

require_relative '/Users/apple/QuizSystem/App/quiz_questions'
require_relative '/Users/apple/QuizSystem/App/user'
require_relative '/Users/apple/QuizSystem/App/student'
require_relative '/Users/apple/QuizSystem/App/teacher'

# wdqd
class Driver
  def initialize; end

  def log_in
    userobj = User.new
    puts 'Please enter your email: '
    email = gets
    unless valid_email?(email.chomp)
      puts 'Invalid email press 1 to retry'
      option = gets.chomp.to_i
      if option.eql?(1)
        log_in
      else
        exit 1
      end
    end
    puts 'Please enter your password: '
    password = gets
    dbuser = userobj.find_user
    log_in_validation(dbuser, email, password)
  end

  def valid_email?(email)
    email_regex = /\A[\w+\-.]+@[a-z\d-]+(\.[a-z\d-]+)*\.[a-z]+\z/i
    email_regex.match?(email)
  end

  def log_in_validation(dbuser, email, password)
    if dbuser.nil?
      if_user_not_exists(userobj)
    else
      dbuser.each do |user|
        next unless user.password.eql?(password) && user.email.eql?(email)

        if_user_exists(user)
      end
      puts '============================'
    end
  end

  def if_user_not_exists(userobj)
    puts 'Sorry, that user does not exist. press 1 to signup?'
    option = gets.to_i.chomp
    if option.eql?(1)
      puts 'Creating user...'
      userobj.sign_up
    else
      puts 'Sorry, that user does not exist. please try again.'
      log_in
    end
  end

  def if_user_exists(user)
    puts "You are logged in as #{user.user_role}"
    case user.user_role.chomp
    when 'teacher'
      teacher_menu(user)
    when 'student'
      student_menu(user)
    else
      puts 'Sorry, that user does not exist. please try again.'
      log_in
    end
  end

  def teacher_menu
    puts '!..!_Teacher Menu_!..!'
    puts '1.. Create a new Quiz'
    puts '2.. Edit an existing Quiz'
    puts '3.. view an existing Quiz'
    puts '4.. view solved Quiz'
    puts "5.. Exit \nEnter your choice:"
    choice = gets.chomp
    choice_menu_teacher(choice)
  end

  def choice_menu_teacher(choice)
    teacher = Teacher.new
    case choice
    when '1'
      teacher.create_quiz
    when '2'
      teacher.edit_quiz
    when '3'
      teacher.view_quiz
    when '4'
      teacher.view_solved_quiz
    else exit 1
    end
  end

  def student_menu(user)
    puts '!..!_Student Menu_!..!'
    puts '1.. View Quiz'
    puts '2.. Attempt Quiz'
    puts 'Enter your choice: '
    choice = gets.chomp
    student_menu_choice(user, choice)
  end

  def student_menu_choice(user, choice)
    student = Student.new
    case choice
    when '1'
      student.view_quiz(user)
    when '2'
      student.attempt_quiz(user)
    else exit 1
    end
  end
end
