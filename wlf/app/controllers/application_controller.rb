class ApplicationController < ActionController::Base
  #CSRF対策無効化　:exception -> :null_sessionへ　naoki
  #TODO: 無効にするcontrollerを絞ったりできるみたいですよ　そうしましょう.
  protect_from_forgery with: :null_session
  include SessionsHelper
end
