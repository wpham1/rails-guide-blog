class Article < ApplicationRecord
include Visible
    # include dependent: :destroy, when deleting things that are also associated with it aka comments
    has_many :comments, dependent: :destroy
    
    validates :title, presence: true
    validates :body, presence: true, length: { minimum: 10 }

    
end
