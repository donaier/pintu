module UsersHelper
  def index_roles(user)
    if user.has_role? :bambi
      I18n.t("role.bambi")
    else
      user.roles.map{ |r| I18n.t("role.#{r.name}") }.join(' | ')
    end
  end

  def message_header(user, message)
    sender = @message.sender.try(:username)
    date = @message.try(:created_at).try(:strftime, '%d.%m.%Y um %H:%M')
    t('messages.from_and_at', sender: sender, date: date)
  end
end
