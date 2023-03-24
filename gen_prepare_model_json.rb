require 'json'

qas = []
File.open("kuranuki_journal1.txt"){ |f|
  question = ''
  answers = []
  f.each_line{ |line|
    if /\A--/.match?(line)
      if !answers.empty?
        qas << {
          "prompt": question.strip,
          "completion": answers.map(&:strip).select { |s| !s.empty? }.join("\n"),
        }
        answers = []
      end
      question = line
    else
      answers << line
    end
  }
}

puts JSON.pretty_generate(qas)
