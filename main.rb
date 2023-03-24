#!/usr/bin/env ruby
require 'openai'
require 'byebug'
require 'readline'

$MESSAGES = [
  { role: 'system', content: 'You are an experienced ShellScript programmer. You answer my questions about shell handling with examples. If you are asked about anything other than Shell, do not answer never.' },
]

def client
  @client ||= OpenAI::Client.new(access_token: ENV['OPENAI_API_KEY'])
end

def ask_gpt(question)
  $MESSAGES << { role: 'user', content: question }

  response = client.chat(
    parameters: {
      model: 'gpt-3.5-turbo',
      messages: $MESSAGES,
    },
  )
  answer = response.dig('choices', 0, 'message', 'content')
  $MESSAGES << { role: 'assistant', content: answer }
  answer
end

def main
  loop do
    question = Readline.readline('Ask anything you want. ( q to exit): ', true).chomp

    break if %w[q quit].include?(question.downcase)

    puts ''
    puts "Q. #{question}"
    answer = ask_gpt(question)
    puts ''
    puts "A. #{answer}"
    puts '-------------------------------------------------'
    puts ''
    puts 'Resolved? If not, keep asking.'
  end
end

main
