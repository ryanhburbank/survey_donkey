User.create(
            email:                  "ryan@gmail.com",
            password:               "password",
            password_confirmation:  "password"
            )
10.times do 
  User.create(email: Faker::Internet.email, 
              password: "password", 
              password_confirmation: "password"
              )
end

 User.all.each do |user|
   Survey.create(user_id: user.id, title: Faker::Lorem.word)
 end

 Survey.all.each do |survey|
   3.times do 
    Question.create(survey_id: survey.id, 
                    text: Faker::Lorem.sentence(word_count = 4)
                    )
   end
 end 

 Question.all.each do |question|
   4.times do 
     Answer.create(question_id: question.id, 
                  text: Faker::Lorem.sentence(word_count = 5)
                  )
   end
 end

