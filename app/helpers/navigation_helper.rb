module NavigationHelper
  def nav_link_to(text, path, **options)
    is_active = current_page?(path) || request.path.start_with?(path.split('?').first)
    css_class = is_active ? 'active' : ''
    css_class = [css_class, options[:class]].compact.join(' ')

    link_to text, path, **options.merge(class: css_class)
  end

  def user_role
    return :guest unless user_signed_in?
    current_user.role
  end

  def show_admin_nav?
    user_signed_in? && current_user.admin?
  end

  def show_team_member_nav?
    user_signed_in? && current_user.team_member?
  end

  def team_member_camps
    return [] unless user_signed_in? && current_user.team_member?
    current_user.team_camps.order(start_date: :desc)
  end
end
