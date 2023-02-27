# frozen_string_literal: true

require_relative '/Users/apple/QuizSystem/App/quiz_answers'

# student class
class Student < User
  def view_quiz(user)
    quiz_attempt = QuizAttempt.new
    quiz_attempt.quiz_select(user)
    continue_student(user)
  end

  def attempt_quiz(user)
    quiz_attempt = QuizAttempt.new
    quiz_attempt.quiz_select(user)
    continue_student(user)
  end
end
