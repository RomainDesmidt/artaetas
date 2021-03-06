ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    # div class: "blank_slate_container", id: "dashboard_default_message" do
    #   span class: "blank_slate" do
    #     span I18n.t("active_admin.dashboard_welcome.welcome")
    #     small I18n.t("active_admin.dashboard_welcome.call_to_action")
    #   end
    # end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end
    
    columns do
      column do
        panel "Annonces en attente de validation" do
          ul do
            Annonce.where(envente_yesno: nil ).map do |annonce|
              li link_to(annonce.name, admin_annonce_path(annonce))
            end
          end
        end
        panel "Annonces refusées" do
          ul do
            Annonce.where(envente_yesno: false ).map do |annonce|
              li link_to(annonce.name, admin_annonce_path(annonce))
            end
          end
        end
        panel "Users nécessitant confirmation(mail)" do
          ul do
            User.where(confirmed_at: nil).map do |user|
              li link_to(user.username, admin_user_path(user))
            end
          end
        end
        panel "Users nécessitant approbation" do
          ul do
            User.where(confirmation_webmaster: false ).map do |user|
              li link_to(user.username, admin_user_path(user))
            end
          end
        end
      end
    end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
