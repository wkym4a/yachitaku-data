class TopController < ApplicationController
  #ログインしているかどうかをチェック
  before_action :authenticate_user!
end
