require 'zip'

def extract_file(file)
Zip::File.open(file) do |zip_file|
  # Handle entries one by one
  zip_file.each do |entry|
    f_path = File.join($target, entry.name)
    FileUtils.mkdir_p(File.dirname(f_path))
    f_dest = $target + 'silverpop_' + "#{Time.now.strftime "%Y-%m-%d-%H%M%S"}" + '.csv'
    entry.extract(f_dest) unless File.exist?(f_dest)
  end
end
end
