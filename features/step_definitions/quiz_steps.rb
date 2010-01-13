Given /^a quiz "([^\"]*)"$/ do |quiz_name|
  Quiz.make(:name => quiz_name)
end

Given /^the quiz "([^\"]*)" has a question "([^\"]*)" with the following answers:$/ do |quiz_name, question, answers|
  quiz = Quiz.find_by_name(quiz_name)
  Question.make(
    :quiz => quiz,
    :text => question,
    :answers_attributes => answers.hashes.map do |row|
      { :text => row['answer'].strip }
    end
  )
end

Given /^the answer "([^\"]*)" is the correct answer for question "([^\"]*)"$/ do |answer, question|
  answer = Answer.find_by_text(answer)
  Question.find_by_text(question).update_attribute(:correct_answer, answer)
end

Given /^"([^\"]*)" failed the "([^\"]*)" quiz$/ do |provider, quiz|
  provider = Provider.find_by_company_name(provider)
  quiz = Quiz.find_by_name(quiz)
  provider.quiz_results.create(:quiz => quiz, :score => 0, :questions => 5)
end

Given /^quiz "([^\"]*)" has "([^\"]*)" questions total, "([^\"]*)" at a time$/ do |quiz, total_questions, questions_per_quiz|
  Quiz.find_by_name(quiz).update_attributes(:total_questions => total_questions, :questions_per_quiz => questions_per_quiz)
end

Given /^question "([^\"]*)" is on the "([^\"]*)" quiz$/ do |question, quiz|
  Quiz.find_by_name(quiz).questions.create!(:text => question)
end

Given /^question "([^\"]*)" has answer "([^\"]*)"$/ do |question, answer|
  Question.find_by_text(question).answers.create!(:text => answer)
end

Given /^answer "([^\"]*)" is the correct answer to "([^\"]*)"$/ do |answer, question|
  answer = Answer.find_by_text(answer)
  Question.find_by_text(question).update_attribute(:correct_answer, answer)
end