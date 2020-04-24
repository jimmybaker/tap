FactoryBot.define do
  factory :project do
    name { "My Project" }
    tags { ["one", "two"] }
    project_type { "a" }
  end
end
