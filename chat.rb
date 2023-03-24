require 'openai'

def chat_message(client)
  puts "\nYou >"
  message = gets.strip

  puts "\nAI >"

  response = client.chat(
    parameters: {
        model: "gpt-3.5-turbo", # Required.
        messages: [{ role: "user", content: message }], # Required.
        temperature: 0.7,
    })

  puts response.dig("choices", 0, "message", "content")
end

def main
  OpenAI.configure do |config|
    config.access_token = ENV.fetch('OPENAI_ACCESS_TOKEN')
    config.organization_id = ENV.fetch('OPENAI_ORGANIZATION_ID') # Optional.
    config.request_timeout = 25
  end

  client = OpenAI::Client.new

  5.times do |n|
    chat_message(client)
  end
end

main
