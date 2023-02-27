# frozen_string_literal: true

# solved quizes
class QuizAttempt < QuizQuestions
  def initaialize; end

  def initialize_quiz(quiz, user)
    puts quiz
    quiz.each do |qus|
      record_attempt(qus, user)
      @@quiz << qus
    end
    puts @@quiz
    save_quiz(@@file_answers)
  end

  def record_attempt(qus, user)
    puts "Q #{qus.question}"
    puts "1. #{qus.option1}"
    puts "2. #{qus.option2}"
    puts "3. #{qus.option3}"
    puts "4. #{qus.option4}"
    puts 'Select Right Option 1,2,3,4'
    qus.answered = gets
    qus.student_name = (user.first_name.chomp + user.last_name.chomp)
  end

  def quiz_select(user)
    allquiz = load_quiz(@@file_quiz)
    puts '!..! Select quiz to Attempt !..!'
    allquiz.each_with_index do |q, i|
      puts "#{i} : #{q[0].quiz_title}"
    end
    puts 'Enter your choice: '
    choice = gets.to_i

    quiz_attempt(allquiz[choice], user)
  end

  def quiz_attempt(quiz, user)
    puts 'Welcome to Quiz !!!'
    initialize_quiz(quiz, user)
  end
end
