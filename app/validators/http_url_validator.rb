# frozen_string_literal: true

class HttpUrlValidator < ActiveModel::EachValidator
  def self.compliant?(value)
    escaped_address = URI::DEFAULT_PARSER.escape(value)
    uri = URI.parse(escaped_address)
    uri.is_a?(URI::HTTP) && !uri.host.nil?
  rescue URI::InvalidURIError
    false
  end

  def validate_each(record, attribute, value)
    return if value.present? && self.class.compliant?(value)

    record.errors.add(attribute, "유효한 HTTP URL이 아닙니다.")
  end
end
