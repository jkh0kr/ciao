# frozen_string_literal: true

# Mailer to send mails about checkhealth updates/changes.
# `From:`, `To:` and other SMTP options are configured at config/environments/production.rb
class CheckMailer < ApplicationMailer
  # Sends mail to inform the receiver about a
  # healthcheck status change
  # @param name [String] the name of the check
  # @param url [String] the URL of the check
  # @param status_before [String] the old status, `1XX..5XX` or `e`
  # @param status_after [String] the new status, `1XX..5XX` or `e`
  def change_status_mail
    @name = params[:name]
    @url = params[:url]
    @status_before = params[:status_before]
    @status_after = params[:status_after]
    mail(subject: "[ciao] #{@name}: 상태가 변경되었습니다. (#{@status_after})")
  end

  # Sends mail to inform the receiver about a
  # expiration of TLS certificate
  # @param name [String] the name of the check
  # @param url [String] the URL of the check
  # @param tls_expires_at [DateTime] DateTime when the TLS certificate expires
  # @param tls_expires_in_days [Integer] Days until the TLS certificate expires
  def tls_expires_mail
    @name = params[:name]
    @url = params[:url]
    @tls_expires_at = params[:tls_expires_at]
    @tls_expires_in_days = params[:tls_expires_in_days]
    mail(subject: "[ciao] #{@name}: TLS 인증서가 #{@tls_expires_in_days}일 후에 만료됩니다.")
  end
end
