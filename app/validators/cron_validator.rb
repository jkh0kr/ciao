# frozen_string_literal: true

class CronValidator < ActiveModel::EachValidator
  def self.compliant?(value)
    cron = ::Fugit::Cron.parse(value)
    cron.present?
  rescue => e
    Rails.logger.info "CronValidator Exception: #{e}"
    false
  end

  def validate_each(record, attribute, value)
    return if value.present? && self.class.compliant?(value)

    record.errors.add(
      attribute,
      "유효한 cron이 아닙니다. 여기에서 cron 일정 표현식을 확인하세요: https://crontab.guru"
    )
  end
end
