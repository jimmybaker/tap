# frozen_string_literal: true

class Project::Contract::Create < Reform::Form
  property :name
  property :tags
  property :project_type

  validation :default do
    configure do
      config.messages_file = 'config/error_messages.yml'

      def unique?(value)
        Project.find_by(name: value).nil?
      end
    end

    required(:name).filled(:unique?)
    required(:project_type).filled(included_in?: %w[a b c])
  end
end
