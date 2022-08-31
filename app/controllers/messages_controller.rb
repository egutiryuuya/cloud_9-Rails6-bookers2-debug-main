class MessagesController < ApplicationController
  def new
    @message = Message.new
    @group = Group.find(params[:group_id])
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      flash[:notice]="送信が完了しました"
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end
  
  private
  def message_params
    params.require(:message).permit(:title, :content)
  end
end
