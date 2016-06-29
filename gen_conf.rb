require 'erb'
`cls`

week_number = ARGV[0]
render_map = ARGV[1] == "true" ? true:false
confreaks_only = ARGV[2] == "true" ? true:false

puts ARGV[1]

if week_number.nil? || render_map.nil?
  puts "You must specify a week number and true/false for auto generate"
else
  puts "Preparing map for Week #{week_number} and render_map is #{render_map}"

  erb = ERB.new(File.open("#{__dir__}/map-gen.conf.erb").read)

  file_name = "#{__dir__}/week#{week_number}.conf"

  file = File.new(file_name,'w')

  file.write erb.result

  file.close

  puts "configuration file generated as '#{file_name}'."

  command = "mapcrafter.exe -c week#{week_number}.conf -j 8"

  if render_map
    puts "\nCommencing MapCrafter build... you can go away for a few hours now..."

    `#{command}`

    puts "Week #{week_number} maps have been generated in d:\minecraft\maps\weeks\#{week_number}"
  else
    puts "command to render is: #{command}"
  end
end

