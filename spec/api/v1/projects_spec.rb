# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'API', type: :request do
  describe 'GET /api/v1/projects' do
    it 'returns a list of projects' do
      40.times do |i|
        Project::Create.call(params: {
                               name: "Project #{i}",
                               tags: %w[one two three],
                               project_type: %w[a b c].sample
                             })
      end

      expect(Project.count).to eq(40)

      (1..4).to_a.each do |page|
        get '/api/v1/projects', params: {
          page: page,
          per: 10
        }
        response = JSON.parse(body)
        expect(response['projects']).to_not be_empty
        expect(response['projects'].count).to eq(10)
        expect(response['meta']['page']).to eq(page)
        expect(response['meta']['item_count']).to eq(40)
        expect(response['meta']['page_count']).to eq(4)
      end
    end
  end

  describe 'POST /api/v1/projects' do
    it 'creates a new project' do
      post '/api/v1/projects', params: {
        project: {
          name: 'Cool Project',
          tags: %w[one two three],
          project_type: 'a'
        }
      }
      project = JSON.parse(body)
      expect(project['name']).to eq('Cool Project')
    end

    it 'renders errors on invalid input' do
      post '/api/v1/projects', params: {
        project: {
          name: 'Cool Project',
          tags: %w[one two three],
          project_type: 'd'
        }
      }

      response = JSON.parse(body)
      expect(response['errors']).to_not be_empty
      expect(response['errors']['project_type']).to eq(['must be one of: a, b, c'])
    end
  end
end
