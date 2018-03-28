module Hyrax
  class ContactForm
    include ActiveModel::Model
    attr_accessor :contact_method, :category, :name, :email, :subject, :message
    validates :email, :category, :name, :subject, :message, presence: true
    validates :email, format: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i, allow_blank: true
    # - can't use this without ActiveRecord::Base validates_inclusion_of :category, in: self.class.issue_types_for_locale

    class << self
      private
      def issue_types
        %w(depositing changing browsing reporting general)
      end

      public
      # TODO: Really this should be in a decorator rather than the model. Slightly sloppy here, but as this is an override
      # of the Hyrax gem code, it's required to be in the model class methods. *Sigh*
      def issue_types_for_locale
        issue_types.map{|issue_type| I18n.t("hyrax.contact_form.issue_types.#{issue_type}")}
      end
    end

    # They should not have filled out the `contact_method' field. That's there to prevent spam.
    def spam?
      contact_method.present?
    end

    # Declare the e-mail headers. It accepts anything the mail method
    # in ActionMailer accepts.
    def headers
      {
          subject: "#{Hyrax.config.subject_prefix} #{subject}",
          to: Hyrax.config.contact_email,

          # Default case:
          # Send email from the admin contact inbox to itself. E.g. if configured to repo-admin@example.ac.uk, email
          # will come from that address and also go to that address. Send on behalf of the actual user's email address
          # (the `email` variable) will only be successful if we have permission to send email on behalf of that user.
          # If the user enters a @gmail.com or @btinternet.com address, we have no chance of obtaining permission and
          # SMTP servers will reject the message, causing the form to fail to send anything.
          # The message body (see the contact_mailer view in Hyrax) still contains the user's email address for admins to see.
          from: ENV['CONTACT_FORM_SENDER_EMAIL'] || Hyrax.config.contact_email  # use `email` as the value instead to try to send on behalf of the user
      }
    end
  end
end
