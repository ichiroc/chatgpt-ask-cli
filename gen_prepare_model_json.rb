require 'json'

unless File.exists?(ARGV[0])
  puts 'file not found.'
  exit(1)
end

qas = []
File.open(ARGV[0]){ |f|
  question = ''
  answers = []
  f.each_line{ |line|
    if /\A--/.match?(line)
      if !answers.empty?
        qas << {
          "prompt": question.gsub(/\A--/, '').strip,
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

# puts JSON.pretty_generate(qas)
puts qas.to_json
exit(0)
