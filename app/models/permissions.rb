# app/models/permissions.rb
class Permissions
  ROLE_PERMISSIONS = {
    admin: %i[
      manage_users manage_campaigns manage_templates manage_credits
      view_reports access_support
    ],
    campaign_manager: %i[
      manage_campaigns view_reports access_support
    ],
    designer: %i[
      manage_templates
    ],
    analyst: %i[
      view_reports
    ],
    user: %i[
      create_campaigns view_own_reports access_support
    ],
    collaborator: %i[
      view_campaigns
    ],
    observer: %i[
      view_campaigns
    ],
    usuario_prepago: %i[
      create_campaigns view_own_reports
    ],
    colaborador_prepago: %i[
      view_campaigns
    ],
    observador_prepago: %i[
      view_campaigns
    ]
  }.freeze

  def self.allowed_actions_for(role)
    ROLE_PERMISSIONS[role.to_sym] || []
  end

  def self.allowed?(role, action)
    allowed_actions_for(role).include?(action)
  end
end
