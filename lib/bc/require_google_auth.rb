require 'bc/require_google_auth/version'

module Bc
  class RequireGoogleAuth

    DEFAULT_ALLOWED_PATHS = [
      "/auth/google_oauth2/callback",
      "/auth/google_oauth2"
    ].freeze

    DEFAULT_SESSION_KEY = 'bc.auth'.freeze

    DEFAULT_AFTER_AUTH_PATH = '/'.freeze

    OMNIAUTH_SESSION_KEY = 'omniauth.auth'.freeze

    def initialize(app, opts={})
      @allowed_paths = opts[:allowed_paths] || DEFAULT_ALLOWED_PATHS
      @session_key = opts[:session_key] || DEFAULT_SESSION_KEY
      @authorized_emails = opts[:authorized_emails]
      @after_auth_path = opts[:after_auth_path] || DEFAULT_AFTER_AUTH_PATH
      @app = app
    end

    def auth_callback?(req)
      return false unless req.path == '/auth/google_oauth2/callback'
      return false unless req.env[OMNIAUTH_SESSION_KEY]
      return false unless req.env[OMNIAUTH_SESSION_KEY][:info]
      return true
    end

    def allowed_path?(req)
      @allowed_paths.include?(req.path)
    end

    def authorized_session?(req)
      !!req.session[@session_key]
    end

    def authorized_email?(req)
      @authorized_emails.include?(req.env[OMNIAUTH_SESSION_KEY][:info][:email])
    end

    def handle_unauthorized
      res = Rack::Response.new
      res.redirect '/auth/google_oauth2', status=302
      res.finish
    end

    def handle_auth_callback(req)
      if authorized_email?(req)
        req.session[@session_key] = req.env[OMNIAUTH_SESSION_KEY][:info]
      else
        req.session.delete(@session_key)
      end

      res = Rack::Response.new
      res.redirect @after_auth_path, status=302
      res.finish
    end

    def call(env)
      req = Rack::Request.new(env)

      if auth_callback?(req)
        handle_auth_callback(req)
      elsif authorized_session?(req) || allowed_path?(req)
        @app.call(env)
      else
        handle_unauthorized
      end
    end
  end
end
