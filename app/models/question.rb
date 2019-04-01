class Question < ApplicationRecord
    validates :content, {presence: true, length: {maximum: 3000}}
    validates :user_id, {presence: true}

    def user
        return User.find_by(id: self.user_id)
    end

    def count_likes
        return Like.where(question_id: self.id).count()
    end

    def count_answers
        return Answer.where(question_id: self.id).count()
    end
end
