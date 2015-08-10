class Broadcast
  def initialize(message)
    alert(message)
  end

  def alert(message)
    health_center = HealthCenter.find_by(phone_number: message.from)
    unless health_center.empty?
      create_client
      HealthPost.where(health_center_id: health_center.id).map do |post|
        post.agents.each do |agent|
          @account.messages.create(
            from: "+12674227124",
            to: agent.phone_number,
            body: mmessage
          )
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
