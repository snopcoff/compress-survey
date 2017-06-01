module ApplicationHelper
    
    def is_checked(question_id, mark)
        current_user.has_done && current_user.questions.find(question_id).answers.find_by(current_user.id).mark == mark
    end
    
end
