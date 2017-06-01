module SurveysHelper
    def total(user)
        t = 0
        user.questions.each do |question|
            t += question.answers.find_by(user_id: user.id).mark
        end
        return t
    end
end
