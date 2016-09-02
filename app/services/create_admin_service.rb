class CreateAdminService
  def call
    user = User.find_or_create_by!(email: Rails.application.secrets.admin_email) do |user|
      user.password = Rais.application.secrets.admin_password
      user.password_confirmation = Rails.application.secrets.admdin_password
      user.confirm!
      user.admin!
    end
  end
end
