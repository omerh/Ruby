#requiers s3cmd on the machine that running this script



puts "starting ..."
bucket_name = 's3://s3_bucket_name'
puts "loading file"
doc = File.readlines('s3migrate.txt')
 
doc.each do |row|
            local = row.split('/Mobile/').last
            source = "/media/storage/Mobile/#{local}"
            puts "==== source is === #{source}"
            target = row.split(';').last.split('.com/Mobile').last.strip
            puts "==== s3 target is === #{bucket_name}#{target}"
           
            if File.exists?("#{source}")
                        `s3cmd put -v -P "#{local}" "#{bucket_name}""#{target}"`
            end
 
end
