# frozen_string_literal: true

require 'json'
# class quiz questions
class QuizQuestions
  @@quiz = []
  @@file_quiz = 'quiz.json'
  @@file_answers = 'attempted_quiz.json'
  attr_accessor :question, :option1, :option2, :option3, :option4, :answer, :answered, :student_name, :quiz_title

  def initialize() end

  def self.quiz
    @@quiz
  end

  def as_json(_options = {})
    {
      quiz_title: @quiz_title,
      question: @question,
      option1: @option1,
      option2: @option2,
      option3: @option3,
      option4: @option4,
      answer: @answer,
      answered: @answered,
      student_name: @student_name
    }
  end

  def to_json(*options)
    as_json(*options).to_json(*options)
  end

  def create_quiz
    puts 'How many questions do you want to create?'
    num = gets.to_i
    num.times do
      puts "Question: #{num}"
      create_question
    end
    save_quiz(QuizAttempt.file_quiz)
  end

  def self.file_quiz
    @@file_quiz
  end

  def self.file_answers
    @@file_answers
  end

  def create_question
    puts '=====Creating Quiz====='
    puts 'Enter Quiz Title: '
    quiz_title = gets.chomp
    puts 'Enter Question: '
    question = gets.chomp
    puts 'Enter Option 1: '
    option1 = gets.chomp
    puts 'Enter Option 2: '
    option2 = gets.chomp
    puts 'Enter Option 3: '
    option3 = gets.chomp
    puts 'Enter Option 4: '
    option4 = gets.chomp
    puts 'Enter Answer: '
    answer = gets.chomp
    create_questions(quiz_title, question, option1, option2, option3, option4, answer)
  end

  def create_questions(quiz_title, question, option1, option2, option3, option4, answer)
    qq = QuizQuestions.new
    qq.quiz_title = quiz_title
    qq.question = question
    qq.option1 = option1
    qq.option2 = option2
    qq.option3 = option3
    qq.option4 = option4
    qq.answer = answer
    @@quiz << qq
  end

  def edit_quiz
    quizload = load_quiz(@@file_quiz)
    puts '=====Editing Quiz====='
    puts 'Select Quiz to Edit: '
    quizload.each_with_index do |qz, i|
      puts "Quiz : #{i + 1}:: #{qz[0].quiz_title}"
    end
    puts 'Enter Quiz number: '
    quiz_id = gets.chomp.to_i
    puts 'Select Question Number: '
    quizload[quiz_id - 1].each_with_index do |qst, _i|
      # puts "Question : #{i + 1}:: #{qst}"
      print_quiz(qst, j)
    end
    puts 'Enter Question Number: '
    question_id = gets.chomp.to_i
    puts 'Enter Quiz Title: '
    quizload[quiz_id - 1][question_id - 1].quiz_title = gets.chomp
    puts 'Enter Question: '
    quizload[quiz_id - 1][question_id - 1].question = gets.chomp
    puts 'Enter Option 1: '
    quizload[quiz_id - 1][question_id - 1].option1 = gets.chomp
    puts 'Enter Option 2: '
    quizload[quiz_id - 1][question_id - 1].option2 = gets.chomp
    puts 'Enter Option 3: '
    quizload[quiz_id - 1][question_id - 1].option3 = gets.chomp
    puts 'Enter Option 4: '
    quizload[quiz_id - 1][question_id - 1].option4 = gets.chomp
    puts 'Enter Answer: '
    quizload[quiz_id - 1][question_id - 1].answer = gets.chomp
    puts quizload
    save_update_quiz(@@file_quiz)
  end

  def save_quiz(file)
    file = File.open(file, 'w') { |f| f << "#{@@quiz.to_json}\n" }
    file.close
  end

  def save_update_quiz(file)
    file = File.open(file, 'w') { |f| f << "#{quizload.to_json}\n" }
    file.close
  end

  def load_quiz(file)
    filebuffer = File.open(file, 'r').read
    filedata = filebuffer.split("\n")
    filedata.map { |line| JSON.parse(line, object_class: OpenStruct) }
  end

  def view_quiz(quizarry)
    quizarry.each_with_index do |qz, i|
      puts '==================================='
      puts "#{i + 1} Quiz Title: #{qz[0].quiz_title}"
      quizarry[i].each_with_index do |qst, j|
        print_quiz(qst, j)
      end
    end
    puts '==================================='
  end

  def print_quiz(qst, ind)
    puts '==================================='
    puts "Q#{ind}: #{qst.question}"
    puts "1. #{qst.option1}"
    puts "2. #{qst.option2}"
    puts "3. #{qst.option3}"
    puts "4. #{qst.option4}"
    puts "Answer:: #{qst.answer}"
    puts "Answer By Student: #{qst.answered}"
    puts "Student Name: #{qst.student_name}"
  end
end
