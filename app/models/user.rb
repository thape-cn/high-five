class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
    :recoverable, :rememberable, :validatable, :trackable

  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles
  has_many :user_job_roles, dependent: :destroy
  has_many :job_roles, through: :user_job_roles
  has_many :user_good_events, dependent: :destroy
  has_many :good_events, through: :user_good_events
  has_many :user_bad_events, dependent: :destroy
  has_many :bad_events, through: :user_bad_events

  normalizes :email, with: ->(email) { email.downcase.strip }

  LOGIN_FORMAT = 'A-Za-z0-9\-\_\.'

  def user_name
    email.split("@").first
  end

  def admin?
    CoreUIsettings.admin.emails.include?(email)
  end

  def role_ids
    @_role_ids ||= user_roles.collect(&:role_id)
  end

  def role_ids=(values)
    select_values = Array(values).reject(&:blank?).map(&:to_i)
    if new_record?
      (select_values - role_ids).each do |to_new_id|
        user_roles.build(role_id: to_new_id)
      end
    else
      (role_ids - select_values).each do |to_destroy_id|
        user_roles.find_by(role_id: to_destroy_id).destroy
      end
      (select_values - role_ids).each do |to_add_id|
        user_roles.create(role_id: to_add_id)
      end
    end
  end

  # default options of datatables: https://datatables.net/reference/option/lengthMenu
  def self.length_menu_options
    [10, 25, 50, 100]
  end

  def self.user_ids_need_to_skip
    @_user_ids_need_to_skip ||= where("email like 'hftest%@thape.com.cn'")
      .pluck(:id)
  end
end
