require "csv"

namespace :import do
  desc "Daily import employee info from SSO"
  task all: %i[user job_role link_user_job_role]

  desc "Import users"
  task :user, [:csv_file] => [:environment] do |task, args|
    csv_file_path = args[:csv_file] || "/home/high_five/EmployeeData/thapeemployee_#{Date.today.strftime("%m%d%Y")}.csv"

    User.where.not(id: User.user_ids_need_to_skip).update_all(is_active: false)
    CSV.foreach(csv_file_path, headers: true) do |row|
      email = correct_email(row["EMAIL"])
      chinese_name = row["LASTNAME"].split("_").first
      hire_date = Date.strptime(row["HIREDATE"], "%Y 年 %m 月 %d 日")
      sf_user_name = row["USERNAME"]

      user = User.find_or_initialize_by(email: email)
      next if User.user_ids_need_to_skip.include?(user.id)

      user.chinese_name = chinese_name
      user.hire_date = hire_date
      user.clerk_code = sf_user_name.split("_").first
      user.is_active = true
      success = user.save(validate: false)
      puts "email: #{email} failed #{user.errors.full_messages.to_sentence}" unless success
    end
  end

  desc "Import job role"
  task :job_role, [:csv_file] => [:environment] do |task, args|
    csv_file_path = args[:csv_file] || "/home/high_five/EmployeeData/thapeemployee_#{Date.today.strftime("%m%d%Y")}.csv"

    CSV.foreach(csv_file_path, headers: true) do |row|
      st_code = row["STCODE"]
      job_level = row["JOBLEVEL"]
      job_code = row["JOBCODE"]
      job_family = row["JOBFAMILY"]

      job_role = JobRole.find_or_initialize_by(st_code: st_code)
      job_role.job_level = job_level
      job_role.job_code = job_code
      job_role.job_family = job_family
      success = job_role.save
      puts "job_role: #{st_code} failed #{job_role.errors.full_messages.to_sentence}" unless success
    end
  end

  desc "Link User and JobRole"
  task :link_user_job_role, [:csv_file] => [:environment] do |task, args|
    csv_file_path = args[:csv_file] || "/home/high_five/EmployeeData/thapeemployee_#{Date.today.strftime("%m%d%Y")}.csv"

    UserJobRole.where.not(user_id: User.user_ids_need_to_skip).update_all(is_active: false)
    CSV.foreach(csv_file_path, headers: true) do |row|
      email = correct_email(row["EMAIL"])
      st_code = row["STCODE"]
      job_user_id = row["USERID"]
      manager_user_id = row["MANAGER"]

      company = row["CUSTOM06"]
      department = row["DEPARTMENT"]
      dept_code = row["CUSTOM01"]
      title = row["TITLE"]

      user = User.find_by email: email
      next if User.user_ids_need_to_skip.include?(user.id)
      puts "user email not found: #{email}" unless user.present?
      job_role = JobRole.find_by st_code: st_code
      puts "job_role st_code not found: #{st_code}" unless job_role.present?
      manager_job_role = UserJobRole.find_by job_user_id: manager_user_id
      manager_user = manager_job_role&.user

      user_job_role = UserJobRole.find_or_initialize_by(user_id: user.id, job_role_id: job_role.id, dept_code: dept_code)
      user_job_role.job_user_id = job_user_id
      user_job_role.manager_user_id = manager_user&.id
      user_job_role.company = company
      user_job_role.department = department
      user_job_role.title = title
      user_job_role.is_active = true
      success = user_job_role.save

      puts "user_job_role: #{email} #{st_code} failed #{user_job_role.errors.full_messages.to_sentence}" unless success
    end
  end

  def correct_email(email)
    first_email_part = email.split("@")[0]
    "#{first_email_part}@thape.com.cn"
  end
end
