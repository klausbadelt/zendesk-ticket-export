require 'csv'
require 'zendesk_api'

z = ZendeskAPI::Client.new do |c|
  c.url = ENV['ZENDESK_URL'] || 'https://filmhub.zendesk.com/api/v2'
  c.username = ENV['ZENDESK_USERNAME']
  c.password = ENV['ZENDESK_PASSWORD']
  c.retry = true
end

CSV.open('open-tickets.csv','wb') do |csv|
  i = 0
  csv << %w{ Date Ticket_ID From Comment Ticket_Date Subject Description Status Channel Tags }
  search = ZendeskAPI::Search.search z, query: "type:ticket status<solved"
  puts "Exporting #{search.count} tickets"
  search.all! do |t|
    print "\r#{i += 1} Tickets exported..."
    t.comments.each do |c|
      csv << [
        c.created_at,
        t.id,
        c.via&.source&.from&.address,
        c.body,
        t.created_at,
        t.subject,
        t.description,
        t.status,
        t.via.channel,
        t.tags.map(&:id).join("|")
      ]
    end
  end
end
