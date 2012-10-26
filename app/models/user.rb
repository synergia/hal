class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ROLES = ["admin", "user"]
  FUNCTIONS = ["member", "board", "pretendent"]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :role, :phone, :project_ids, :function
  # attr_accessible :title, :body

  validates_presence_of :name

  has_many :items
  has_and_belongs_to_many :projects
  has_many :orders

  after_create { |admin| admin.send_reset_password_instructions }

  def password_required?
    new_record? ? false : super
  end

end
