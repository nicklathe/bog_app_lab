class Creatures < ActiveRecord::Base
    # validates :name, :uniqueness => {:case_sensitive => false}
    validates :name, presence: true, :uniqueness => {:case_sensitive => false}, length: { minimum: 5 }
end
