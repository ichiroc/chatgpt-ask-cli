require 'json'
qas = []
question = ''
answers = []
ARGV.each do |file_name|
  unless File.exists?(file_name)
    puts 'file not found.'
    exit(1)
  end

  File.open(file_name){ |f|
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
end

# # puts JSON.pretty_generate(qas)
puts qas.to_json
exit(0)
