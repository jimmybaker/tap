require 'spec_helper'

RSpec.describe "API", type: :request do
  describe 'GET /api/v1/projects' do
    it 'returns a list of projects' do
      get '/api/v1/projects'
      projects = JSON.parse(body)
      expect(projects).to_not be_empty
    end
  end
  
  describe 'POST /api/v1/projects' do
    it 'creates a new project' do
      post '/api/v1/projects', params: {
        project: {
          name: "Cool Project",
          tags: ["one", "two", "three"],
          project_type: "a"
        }
      }
      projects = JSON.parse(body)
      expect(projects).to_not be_empty
    end
  end
end