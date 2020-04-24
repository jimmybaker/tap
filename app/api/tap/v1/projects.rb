module Tap
  module V1
    class Projects < ::Grape::API
      version 'v1', using: :path
      format :json
      prefix :api

      resource :projects do
        desc 'Returns a list of projects'
        get do
          present [{ name: "Project 1"}]
        end

        desc 'Creates a new project'
        params do
          requires :project, type: Hash do
            requires :name, type: String
            # optional :tags, type: Array do
            requires :project_type, type: String
          end
        end
        post do
          result = Project::Create.call(params: params[:project])
          if result.success?
            present result[:model]
          else
            present result[:errors]
          end
        end
      end
    end
  end
end