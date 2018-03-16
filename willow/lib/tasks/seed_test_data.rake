namespace :willow do
  desc 'Seeds test data, will read from specified file usage: willow:seed_test_data["seed_file.json"]'
  task :"seed_test_data", [:seedfile] => :environment do |task, args|
    seedfile = args.seedfile
    unless args.seedfile.present?
      seedfile = Rails.root.join("seed","demo.json")
    end

    root_dir = File.dirname(File.dirname(seedfile))

    if (File.exists?(seedfile))
      puts("Running seedfile: #{seedfile}")
    else
      abort("ERROR: missing seedfile: #{seedfile}")
    end

    seed = JSON.parse(File.read(seedfile))

    ##############################################
    # make the requested users
    ######

    depositor = false
    admin = Role.where(name: "admin").first_or_create!
    seed["users"].each do |user|
      newUser = User.where(email: user["email"]).first_or_create!(password: user["password"], display_name: user["name"])

      if user["role"] == "admin"
        unless admin.users.include?(newUser)
          admin.users << newUser
          admin.save!
        end
      end

      if user.has_key?("depositor")
        depositor = newUser
      end
    end

    # finished creating users
    ##############################################

    ##############################################
    # populate the site text
    ######

    seed["site_text"].each do |key, array|
      html = array.join("")
      if key == "marketing"
        marketing_text = ContentBlock.where(name: "marketing_text").first_or_create!
        marketing_text.value=html
        marketing_text.save!
      elsif key == "about"
        about_page = ContentBlock.where(name: "about_page").first_or_create!
        about_page.value=html
        about_page.save!
      elsif key == "help"
        help_page = ContentBlock.where(name: "help_page").first_or_create!
        help_page.value=html
        help_page.save!
      end
    end

    # finished populating site text
    ##############################################


    ##############################################
    # Create administrative sets
    ######

    administrative_sets = {}
    if seed.has_key?("administrative_sets")
      seed["administrative_sets"].each do |administrative_set|
        arguments = {}
        administrative_set["metadata"].each do |key, val|
          arguments[key.to_sym] = val
        end

        as = AdminSet.where(id: administrative_set["id"]).first || AdminSet.create!(
          id: administrative_set["id"],
          **arguments)

        if administrative_set.has_key?("permission_template")
          pt = Hyrax::PermissionTemplate
                   .where(source_id: administrative_set["id"])
                   .first_or_create!

          if administrative_set["permission_template"].has_key?("permission_template_access")
            administrative_set["permission_template"]["permission_template_access"].each do |pta|
              Hyrax::PermissionTemplateAccess
                  .where(permission_template: pt,
                         agent_type: pta["agent_type"],
                         agent_id: pta["agent_id"],
                         access: pta["access"])
                  .first_or_create!
            end
          end
        end

        administrative_sets[administrative_set["id"]] = as
      end
    end

    # finished administrative sets
    ##############################################
    
    Hyrax::Workflow::WorkflowImporter.load_workflows


    ##############################################
    # Configure workflow_responsibilities
    ######

    if seed.has_key?("workflow_responsibilities")
      seed["workflow_responsibilities"].each do |workflow_responsibility|
        user = User.where(email: workflow_responsibility["user_email"]).first
        agent = Sipity::Agent.where(proxy_for_id: user, proxy_for_type: user.class.name).first_or_create!
        workflow = Sipity::Workflow.where(name: workflow_responsibility["workflow_name"]).first
        workflow.active = true # ensure the one_step_mediated_deposit is active
        workflow.save
        role = Sipity::Role.where(name: workflow_responsibility["role_name"]).first
        workflow_role = Sipity::WorkflowRole.where(workflow: workflow, role: role).first

        if user.present? && agent.present? && workflow.present? && role.present? && workflow_role.present?
          Sipity::WorkflowResponsibility.where(agent: agent, workflow_role: workflow_role).first_or_create!
        else
          abort("Unable to create workflow_responsibility : user: #{user}, agent: #{agent}, workflow: #{workflow}, role: #{role}, workflow_role: #{workflow_role}")
        end
      end
    end

    # finished workflow_responsibilities
    ##############################################
  end
end
