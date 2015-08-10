module Twitter
  class API < Grape::API
    version 'v1', using: :header, vendor: 'twitter'
    format :json
    prefix :api

    helpers do

      def warden
        env['warden']
      end

      def authenticated
        return true if warden.authenticated?
        params[:access_token] && @user = User.find_by_authentication_token(params[:access_token])
      end

      def current_user
        warden.user || @user
      end

    end

    resource :statuses do
      desc "Return a public timeline."
      get :public_timeline do
        Message.limit(20)
      end

      desc "Return a personal timeline."
      get :home_timeline do
        if authenticated
          current_user.messages.limit(20)
        end
      end

      desc "Return a message."
      params do
        requires :id, type: Integer, desc: "Status id."
      end
      route_param :id do
        get do
          Message.find(params[:id])
        end
      end

      desc "Create a message."
      params do
        requires :message, type: String, desc: "Your status."
      end
      post do
        authenticate!
        Message.create!({
          user: current_user,
          text: params[:message]
        })
      end

      desc "Update a message."
      params do
        requires :id, type: String, desc: "Message ID."
        requires :message, type: String, desc: "Your message."
      end
      put ':id' do
        authenticate!
        current_user.messages.find(params[:id]).update({
          user: current_user,
          text: params[:message]
        })
      end

      desc "Delete a message."
      params do
        requires :id, type: String, desc: "Message ID."
      end
      delete ':id' do
        authenticate!
        current_user.messages.find(params[:id]).destroy
      end
    end
  end
end