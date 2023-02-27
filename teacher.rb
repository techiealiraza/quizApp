# frozen_string_literal: true

require_relative '/Users/apple/QuizSystem/App/quiz_answers'
require_relative '/Users/apple/QuizSystem/App/driver'
# teacher class
class Teacher < User
  def create_quiz(user)
    quiz_attempt = QuizAttempt.new
    quiz_attempt.create_quiz
    continue_teacher(user)
  end

  def edit_quiz(user)
    quiz_attempt = QuizAttempt.new
    quiz_attempt.edit_quiz
    continue_teacher(user)
  end

  def view_solved_quiz(user)
    quiz_attempt = QuizAttempt.new
    quiz_attempt.view_quiz(quiz_attempt.load_quiz(QuizAttempt.file_answers))
    continue_teacher(user)
  end

  def view_quiz(user)
    quiz_attempt = QuizAttempt.new
    quiz_attempt.view_quiz(quiz_attempt.load_quiz(QuizAttempt.file_quiz))
    continue_teacher(user)
  end
end
