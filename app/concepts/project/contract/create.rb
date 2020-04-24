class Project::Contract::Create < Reform::Form
  property :name
  property :tags
  property :project_type

  validation :default do
    required(:name).filled
    required(:project_type).filled(included_in?: %w[a b c])
  end
end