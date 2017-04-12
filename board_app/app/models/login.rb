class Login

  include ActiveModel::Model
  include ActiveModel::Validations
  include ActiveModel::Validations::Callbacks
  attr_accessor :eamil, :password

  validates :email, presence: true
  validates_format_of :email, with: /\A.+@.+\Z/
  validates :password, length: { minimum: 5 }

  validate :authenticate

  def authenticate
    user = User.find_by_email email
    if user
      unless user.authenticate(password)
        errors.add(:password, :not_matched)
      end
    else
      errors.add(:email, :not_found)
    end
  end

end