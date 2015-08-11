class Broadcast
  attr_reader :health_center

  def alert(message)
    if find_health_center_by_message(message)
      create_client
      agents.each do |agent|
          @account.messages.create(
            from: "+12674227124",
            to: agent.phone_number,
            body: message.body
          )
      end
    end
  end

  private

  def create_client
    @client ||= Twilio::REST::Client.new ENV["ACCOUNT_SID"], ENV["AUTH_TOKEN"]
    @account = @client.account
  end

  def find_health_center_by_message(message)
    @health_center = HealthCenter.find_by(phone_number: message.from)
  end

  def agents
    HealthPost.where(health_center_id: @health_center.id).map { |post| post.agents }.first
  end
end
