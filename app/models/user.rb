class User < ApplicationRecord
    has_secure_password
    validates :name, {presence: true, length: {maximum: 50}}
    validates :email, {presence: true, uniqueness: {case_sensitive: false}, length: {maximum: 255}}
    validates :password, {presence: true, length: {minimum: 6}, allow_nil: true}

    def questions
        return Question.where(user_id: self.id)
    end

    def answers
        return Answer.where(user_id: self.id)
    end

    def likes
        return Like.where(user_id: self.id)
    end
end
