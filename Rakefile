require "rubocop/rake_task"

task default: %w[lint run]

RuboCop::RakeTask.new(:lint) do |task|
  task.patterns = ["lib/**/*.rb", "test/**/*.rb"]
  task.fail_on_error = false
end

task :run do
  ruby "lib/gpa_calc.rb"
end
