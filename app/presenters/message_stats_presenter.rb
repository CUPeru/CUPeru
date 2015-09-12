module MessageStatsPresenter
  extend self

  def stats
    @stats = Message.stats
  end

  def to_readable
    "Total Messages Sent: #{stats[:total]}\n"\
      "Emergencies: #{stats[:emergencies]}\n"\
      "Broadcasts: #{stats[:broadcasts]}\n"
  end
end
