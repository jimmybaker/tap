module Tap
  class Base < Grape::API
    mount Tap::V1::Projects
  end
end