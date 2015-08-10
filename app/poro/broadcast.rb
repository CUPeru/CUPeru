class Broadcast
  def initialize(message)
    alert(message)
  end

  def alert
    health_post = HealthPost.where(phone_number: message.from)
    unless health_post.empty?
      create_client
      health_post.first.agents.each do |agent|
        @account.messages.create(
          from: health_post.phone_number,
          to: agent.phone_number,
          body: @message
        )
        redirect_to '/dashboard'
      end
    end
  end

  private

  def create_client
    @client = Twilio::REST::Client.new ENV["ACCOUNT_SID"], ENV["AUTH_TOKEN"]
    @account = @client.account
  end
end
