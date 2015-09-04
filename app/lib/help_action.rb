class HelpAction < Action
  LEXICON = {
    general:   :general_help,
    register:  :register_help,
    info:      :info_help,
    broadcast: :broadcast_help,
    auto:      :auto_help,
    fw:        :fw_help
  }

  def perform
    TwilioClient.send_text(
      to: message.from,
      from: ENV['twilio_phone_number'],
      body: help_message)
  end

  private

  def help_message
    send(LEXICON.fetch(tokens[:topic], :general_help))
  end

  def parse_tokens
    {
      type: lexed_tokens[0],
      topic: lexed_tokens.fetch(1, "").downcase.to_sym
    }
  end

  def general_help
    register_help + broadcast_help + auto_help + fw_help + info_help
  end

  def register_help
    "To register, send 'REGISTER AGENT username' or 'REGISTER TECNICO username'\n"
  end

  def info_help
    "For info on a user, send 'INFO  username'\n"
  end

  def broadcast_help
    "To broadcast a message, send 'BROADCAST message text'\n"
  end

  def auto_help
    "To set an autoreply, send 'AUTO SET message text'\n"\
      "To turn off your autoreply, send 'AUTO OFF'\n"\
      "To see your autoreply, send 'AUTO SHOW'"
  end

  def fw_help
    "To set a forwarding number, send 'FW SET number'\n"\
      "To turn off forwarding, send 'FW OFF'\n"\
      "To see your forwarding number, send 'FW SHOW'\n"
  end
end
