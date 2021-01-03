class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @inbox = current_user.mailbox.inbox

    if current_user.receipts.where(id: params[:mID]).any?
      @message = current_user.receipts.find(params[:mID]).message
      current_user.mark_as_read(@message)
    end
  end

  def new
    @message = Mailboxer::Message.new
  end

  def create
    if params[:mailboxer_message][:recipients]
      recipient = User.find_by_username(params[:mailboxer_message][:recipients])
      if recipient
        current_user.send_message(recipient, params[:mailboxer_message][:body], params[:mailboxer_message][:subject])
      end
    else
      User.all.each do |u|
        current_user.send_message(u, params[:mailboxer_message][:body], params[:mailboxer_message][:subject])
      end
    end

    redirect_to messages_path, alert: I18n.t('messages.send_success')
  end

  def destroy
    current_user.receipts.where(id: params[:id]).mark_as_deleted
    redirect_to messages_path
  end
end
