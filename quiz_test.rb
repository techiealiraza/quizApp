# frozen_string_literal: true

require 'json'
require_relative 'quiz_questions'

RSpec.describe QuizQuestions do
  before(:all) do
    @quiz_question = QuizQuestions.new
    @quiz_question.question = "What is the capital of France?"
    @quiz_question.option1 = "New York"
    @quiz_question.option2 = "Paris"
    @quiz_question.option3 = "London"
    @quiz_question.option4 = "Sydney"
    @quiz_question.answer = "2"
    @quiz_question.student_name = "Alice"
    @quiz_question.quiz_title = "Geography Quiz"
  end

  it "creates a new quiz question object" do
    expect(@quiz_question).to be_an_instance_of QuizQuestions
  end

  it "saves the quiz in a JSON file" do
    @quiz_question.create_questions("Geography Quiz Asia", "What is the capital of Pakistan?", "Lahore", "Paris", "London", "Sydney", "1")
    @quiz_question.save_quiz(QuizQuestions.file_quiz)
    quiz_file = JSON.parse(File.read(QuizQuestions.file_quiz))
    expect(quiz_file.length).to be > 0
  end

  it "loads the quiz from a JSON file" do
    quiz_data = @quiz_question.load_quiz(QuizQuestions.file_quiz)
    expect(quiz_data.length).to be > 0
  end

  it "edits a quiz question" do
    quiz_data = @quiz_question.load_quiz(QuizQuestions.file_quiz)
    @quiz_question.edit_quiz
    updated_quiz_data = @quiz_question.load_quiz(QuizQuestions.file_quiz)
    expect(updated_quiz_data).to eq(quiz_data)
  end

  it "prints the quiz to the console" do
    quiz_data = @quiz_question.load_quiz(QuizQuestions.file_quiz)
    expect { @quiz_question.view_quiz(quiz_data) }.to output.to_stdout
  end
end