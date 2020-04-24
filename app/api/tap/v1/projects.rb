# frozen_string_literal: true

module Tap
  module V1
    class Projects < ::Grape::API
      version 'v1', using: :path
      format :json
      prefix :api

      resource :projects do
        desc 'Returns a list of projects'
        params do
          optional :page, type: Integer, default: -> { 1 }
          optional :per, type: Integer, default: -> { 10 }
          optional :sort_attr, type: String, default: -> { 'id' }
          optional :order, type: String, default: -> { 'asc' }
        end
        get do
          sort_attr = params[:sort_attr]
          order = params[:order]
          finder = Project.order("#{sort_attr} #{order}")
          paginator = Paginator.new(finder, page: params[:page], per: params[:per])

          present({
                    projects: paginator.records,
                    meta: {
                      page: paginator.page,
                      item_count: paginator.item_count,
                      page_count: paginator.page_count
                    }
                  })
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
            present({
                      errors: result['result.contract.default'].errors.messages
                    })
          end
        end
      end
    end
  end
end
