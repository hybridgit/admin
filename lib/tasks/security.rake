namespace :security do
  desc "Populate database tables with sample data"
  task :admin => :environment do
    # Create Admin Role
    @admin_role = Role.create name: "Administrator", description: "Role given to the administors of the system."
    puts "Admin Role created"
    # Create Admin User
    @admin = User.create username: "admin", email: "admin@ride.com.et", password: "P@ssw0rd!", password_confirmation: "P@ssw0rd!"
    puts "Admin User created"
    # Assign Admin Role to username
    @admin.user_roles.build(@admin_role.id)
    puts "Admin assigned Role"
    # Save changes made to the User
    @admin.save
    puts "Changes saved!"
  end
end
