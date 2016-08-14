module Admin
  class MailsController < ApplicationController
    MAILERS = [ImportMailer, OrderMailer]

    before_action :find_and_build_mail, only: [:show, :preview]

    def index
      @grouped_emails = grouped_emails
    end

    def show
    end

    def preview
      render text: @mail.body
    end

    private

    def find_and_build_mail
      mailer_name, action_name = params[:id].split('|')
      mailer = MAILERS.find { |mailer| mailer.name == mailer_name }
      action = mailer.action_methods.find { |action| action.to_s == action_name }
      mail_params = get_mail_params [mailer_name, action_name]
      @mail = mailer.send(action, *mail_params)
    end

    def grouped_emails
      MAILERS.each_with_object({}) do |mailer, hsh|
        hsh[mailer.to_s] = mailer.action_methods.map(&:to_s)
      end
    end

    def get_mail_params(mail)
      case mail
      when %w(ImportMailer notification)
        order = Order.first
        [order&.email, order&.order_items&.first&.image_nr]
      when %w(OrderMailer order_confirmation)
        order = Order.first
        [order]
      when %w(OrderMailer changed_status)
        order = Order.first
        [order.id]
      end
    end
  end
end
