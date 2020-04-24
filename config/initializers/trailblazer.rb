require 'reform'
require 'reform/form/dry'
require 'reform/form/coercion'

Reform::Contract.class_eval do
  feature Reform::Form::Dry
end

Reform::Form.class_eval do
  feature Reform::Form::Dry
end