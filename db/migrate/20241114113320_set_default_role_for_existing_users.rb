class SetDefaultRoleForExistingUsers < ActiveRecord::Migration[7.0]
  def up
    User.where(role: nil).update_all(role: 'user')  # Set role to 'user' for users with nil role
  end

  def down
    User.where(role: 'user').update_all(role: nil)  # Optional rollback to set role back to nil
  end
end
