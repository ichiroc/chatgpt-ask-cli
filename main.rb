#!/usr/bin/env ruby
require 'openai'
require 'byebug'
require 'readline'

$MESSAGES = [
  { role: 'system', content: 'You are an experienced ShellScript programmer. You answer my questions about shell handling with examples.' },
]

# GPT-4に質問を投げる関数
def ask_gpt(question)
  client = OpenAI::Client.new(access_token: ENV['API_KEY'])
  prompt = "シェルコマンド: #{question}\n回答:"
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
  puts 'シェルコマンドヘルパーへようこそ！'

  loop do
    question = Readline.readline("質問を入力してください (終了するには 'q' または 'quit' と入力): ", true).chomp

    break if %w[q quit].include?(question.downcase)

    answer = ask_gpt(question)
    puts '-------------------------------------------------'
    puts "質問: #{question}"
    puts "回答: #{answer}\n\n"
  end

  puts 'プログラムを終了します。'
end

main
