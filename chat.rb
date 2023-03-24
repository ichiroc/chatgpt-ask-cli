require 'openai'

def main
  puts "質問を入力してください >"
  question = gets.strip

  puts "\n... ...\n\n"

  OpenAI.configure do |config|
    config.access_token = ENV.fetch('OPENAI_ACCESS_TOKEN')
    config.organization_id = ENV.fetch('OPENAI_ORGANIZATION_ID') # Optional.
    config.request_timeout = 25
  end

  client = OpenAI::Client.new

  response = client.chat(
    parameters: {
        model: "gpt-3.5-turbo", # Required.
        messages: [{ role: "user", content: question }], # Required.
        temperature: 0.7,
    })

  puts response.dig("choices", 0, "message", "content")
end

main
