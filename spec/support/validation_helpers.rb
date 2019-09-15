RSpec::Matchers.define :validate_with do |validator_class|
  match do |record|
    record_validator_classes = record.class.validators.lazy.map(&:class)

    validator_class.in?(record_validator_classes)
  end
end
