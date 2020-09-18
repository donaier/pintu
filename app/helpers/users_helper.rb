module UsersHelper
  def index_roles(user)
    if user.has_role? :bambi
      I18n.t("role.bambi")
    else
      user.roles.map{ |r| I18n.t("role.#{r.name}") }.join(' | ')
    end
  end
end
