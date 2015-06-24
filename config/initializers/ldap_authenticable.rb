require 'net/ldap'
require 'devise/strategies/authenticatable'

module Devise
  module Strategies
    class LdapAuthenticatable < Authenticatable
      def authenticate!
        if params[:user]
          if username.blank?
            fail(:username_required)
          elsif password.blank?
            fail(:password_required)
          else
            # ldap = Net::LDAP.new(auth: {method: :simple, username: ldap_username, password: password})
            # ldap.host = LDAPConfig[Rails.env]["host"]
            # ldap.port = LDAPConfig[Rails.env]["port"]
            # ldap.base = LDAPConfig[Rails.env]["base"]
            # if ldap.bind
              user = User.find_by_username(username)
              if user
                success!(user)
              else
                fail(:inactive)
              end
            # else
            #   fail(:invalid)
            # end
          end
        end
      end

      def valid?
        params[:user] && (params[:user][:username] || params[:user][:password])
      end

      def username
        params[:user][:username]
      end      

      def ldap_username
        params[:user][:username] + "@trantorchd.com"
      end

      def password
        params[:user][:password]
      end
    end
  end
end

Warden::Strategies.add(:ldap_authenticatable, Devise::Strategies::LdapAuthenticatable)


module Devise
  module Models
    # LDAP Module, responsible for validating the user credentials via LDAP.
    #
    # Examples:
    #
    #    User.authenticate('email@test.com', 'password123')  # returns authenticated user or nil
    #    User.find(1).valid_password?('password123')         # returns true/false
    #
    module LdapAuthenticatable
      extend ActiveSupport::Concern

      included do
        attr_reader :current_password, :password
        attr_accessor :password_confirmation
      end

      def login_with
        @login_with ||= Devise.mappings.find {|k,v| v.class_name == self.class.name}.last.to.authentication_keys.first
        self[@login_with]
      end

      def change_password!(current_password)
        raise "Need to set new password first" if @password.blank?

        Devise::LDAP::Adapter.update_own_password(login_with, @password, current_password)
      end
      
      def reset_password!(new_password, new_password_confirmation)
        if new_password == new_password_confirmation && ::Devise.ldap_update_password
          Devise::LDAP::Adapter.update_password(login_with, new_password)
        end
        clear_reset_password_token if valid?
        save
      end

      def password=(new_password)
        @password = new_password
        if defined?(password_digest) && @password.present? && respond_to?(:encrypted_password=)
          self.encrypted_password = password_digest(@password) 
        end
      end

      # Checks if a resource is valid upon authentication.
      def valid_ldap_authentication?(password)
        Devise::LDAP::Adapter.valid_credentials?(login_with, password)
      end

      def ldap_entry
        @ldap_entry ||= Devise::LDAP::Adapter.get_ldap_entry(login_with)
      end

      def ldap_groups
        Devise::LDAP::Adapter.get_groups(login_with)
      end

      def in_ldap_group?(group_name, group_attribute = LDAP::DEFAULT_GROUP_UNIQUE_MEMBER_LIST_KEY)
        Devise::LDAP::Adapter.in_ldap_group?(login_with, group_name, group_attribute)
      end

      def ldap_dn
        ldap_entry ? ldap_entry.dn : nil
      end

      def ldap_get_param(param)
        if ldap_entry && !ldap_entry[param].empty?
          value = ldap_entry.send(param)
        else
          nil
        end
      end

      #
      # callbacks
      #

      # # Called before the ldap record is saved automatically
      # def ldap_before_save
      # end

      # Called after a successful LDAP authentication
      def after_ldap_authentication
      end


      module ClassMethods
        # Find a user for ldap authentication.
        def find_for_ldap_authentication(attributes={})
          auth_key = self.authentication_keys.first
          return nil unless attributes[auth_key].present?

          auth_key_value = (self.case_insensitive_keys || []).include?(auth_key) ? attributes[auth_key].downcase : attributes[auth_key]
          auth_key_value = (self.strip_whitespace_keys || []).include?(auth_key) ? auth_key_value.strip : auth_key_value

          resource = where(auth_key => auth_key_value).first

          if resource.blank? && ::Devise.ldap_create_user
            resource = new
            resource[auth_key] = auth_key_value
            resource.password = attributes[:password]
          end

          if resource && resource.new_record? && resource.valid_ldap_authentication?(attributes[:password])
            resource.ldap_before_save if resource.respond_to?(:ldap_before_save)
            resource.save!
          end

          resource
        end

        def update_with_password(resource)
          puts "UPDATE_WITH_PASSWORD: #{resource.inspect}"
        end

      end
    end
  end
end

Devise.add_module(:ldap_authenticatable,
                  :route => :session, ## This will add the routes, rather than in the routes.rb
                  :strategy   => true,
                  :controller => :sessions,
                  :model  => 'devise_ldap_authenticatable/model')
