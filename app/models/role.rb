class Role < ApplicationRecord
  has_and_belongs_to_many :users, :join_table => :users_roles

  belongs_to :resource,
             :polymorphic => true,
             :optional => true


  validates :resource_type,
            :inclusion => { :in => Rolify.resource_types },
            :allow_nil => true

  scopify

  roles_for_new_users = [
    'pre_user_manager'
  ]
  real_roles = [
    'user_manager'
  ]

  scope :for_new_user, -> { where(name: roles_for_new_users) }
  scope :real, -> { where(name: real_roles) }
end
