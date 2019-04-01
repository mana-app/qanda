class Like < ApplicationRecord
    validates :user_id, {presence: true}
    validates :question_id, {presence: true}

end
