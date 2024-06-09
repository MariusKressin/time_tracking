module ApplicationHelper
  def role_name(role)
    case role
    when 0
      'Guest'
    when 1
      'Employee'
    when 2
      'Supervisor'
    when 3
      'Admin'
    when 4
      'Superadmin'
    end
  end
end
