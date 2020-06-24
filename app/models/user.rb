class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :chat_messages, dependent: :nullify
  has_many :chat_users, dependent: :nullify
  has_many :chat_rooms, through: :chat_users
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name,  presence: true,
                    length: { maximum: 30 }


  # スコープ
  scope :where_category, ->(category) { where(posts: { category: category }) }


  # メソッド
  def self.guest
    find_or_create_by!(name: 'ゲストユーザー', email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
    end
  end
end
