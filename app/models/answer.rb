class Answer < ApplicationRecord
    validates :content, {presence: true, length: {maximum: 3000}}
    validates :question_id, {presence: true}
    validates :user_id, {presence: true}

    def question
        return Question.find_by(id: self.question_id)
    end
end
