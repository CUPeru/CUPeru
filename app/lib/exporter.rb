require 'csv'

class Exporter
  attr_reader :scope

  def self.run
    self.new.run
  end

  def initialize(scope = nil)
    @scope = scope
  end

  def run
    data = message_data
    CSV.open("public/#{path}", 'w') do |csv|
      csv << MessageCSVPresenter::HEADERS
      data.each do |row|
        csv << row
      end
    end
    path
  end

  def message_data
    scope ? Message.send(scope).map(&:to_row) : Message.all.map(&:to_row)
  end

  private

  def filename
    scope ? "#{scope.to_s}_messages.csv" : "messages.csv"
  end

  def path
    "export/#{filename}"
  end
end
