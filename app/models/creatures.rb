class Creatures < ActiveRecord::Base
    # validates :name, :uniqueness => {:case_sensitive => false}
    validates :name, presence: true, :uniqueness => {:case_sensitive => false}, format: { with: /\A[a-z\sA-Z]+\z/,
    message: "only allows letters" }
    validates :desc, presence: true, length: { in: 10..255 }
end
