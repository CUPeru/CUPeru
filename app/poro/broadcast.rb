class Broadcast
  def initialize(message)
    alert(message)
  end

  def alert
    health_center = HealthCenter.where(phone_number: message.from)
    unless health_center.empty?
      create_client
      health_center.first.health_posts.map do |post|
        post.agents.each do |agent|
          @account.messages.create(
            from: "+12674227124",
            to: agent.phone_number,
            body: @message
          )
          redirect_to '/dashboard'
        end
      end
    end
  end

  private

  def create_client
    @client = Twilio::REST::Client.new ENV["ACCOUNT_SID"], ENV["AUTH_TOKEN"]
    @account = @client.account
  end
end
