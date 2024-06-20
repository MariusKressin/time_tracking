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
      'Creator'
    when 5
      'Developer'
    end
  end

  def new_user_options(role)
    case role
    when 5
      [['Employee', 1], ['Supervisor', 2], ['Admin', 3], ['Creator', 4], ['Developer', 5]]
    when 4
      [['Employee', 1], ['Supervisor', 2], ['Admin', 3]]
    when 3
      [['Employee', 1], ['Supervisor', 2]]
    when 2
      [['Employee', 1]]
    when 1
      []
    end
  end
end
