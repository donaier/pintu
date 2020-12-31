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
    params[:mailboxer_message]
    recipient = User.find_by_username(params[:mailboxer_message][:recipients])

    if recipient
      current_user.send_message(recipient, params[:mailboxer_message][:subject], params[:mailboxer_message][:body])
    end
  end
end
