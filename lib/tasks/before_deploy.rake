desc "include custom landing page before heroku san deploys"
task :before_deploy => :environment do

    each_heroku_app do |stage|
      home_file = stage.config['HOME_FILE_DESKTOP']
    # Perform this task only if custom landing page is not present in app/views/home/_show.html.haml
    if home_file.present?
      puts "-----> custom landing page(s) detected..."
      puts "-----> including custom landing page(s) in a temp commit"

      @did_not_stash = system("git stash| grep 'No local changes to save'")      
      system("git add #{home_file} -f") ? true : fail
      system("git commit -m 'adding custom landing page(s) for heroku'") ? true : fail

      puts "-----> done"
    end
  end

end
