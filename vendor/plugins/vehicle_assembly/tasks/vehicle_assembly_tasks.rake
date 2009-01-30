before "bootstrap:cold", "bootstrap:update_cache"
after "deploy", "webapp:set_ownership"

namespace :bootstrap do

  desc "Bootstraps a cold instance"
  task :cold do
    ubuntu
    apache
    gems
    git
    webapp
    passenger
    mysql
    sqlite
  end
  
  task :ubuntu do
    run "apt-get install ruby1.8-dev -y"
    run "apt-get install gcc -y"
    run "apt-get install build-essential -y"
  end
  
  desc "Bootstraps Apache 2"
  task :apache do
    run "apt-get install apache2 -y"
    run "apt-get install apache2-prefork-dev -y"
  end
  
  desc "Bootstraps Rubygems (including Passenger and Rails)"
  task :gems do
    run "apt-get install rubygems -y"
    run "gem update"
    run "gem update --system"
    put File.read('lib/deploy/gem.rb'), "/usr/bin/gem"
    run "gem install passenger --no-ri --no-rdoc"
    run "gem install rails --no-ri --no-rdoc"    
  end

  desc "Bootstraps Git"
  task :git do
    run "apt-get install git-core -y"
  end
    
  desc "Bootstraps the web app environment"
  task :webapp do
    run "mkdir /var/rails" 
  end
  
  desc "Bootstraps Apache 2 with Passenger"
  task :passenger do
    run "cd #{passenger_root}; rake clean apache2"
    template = ERB.new File.read("lib/deploy/templates/passenger.erb")
    prepared = template.result(binding)
    put prepared, "/etc/apache2/passenger.conf"
    run "cat /etc/apache2/passenger.conf >> /etc/apache2/apache2.conf"
    run "rm /etc/apache2/passenger.conf"
    run "/etc/init.d/apache2 restart"
  end
  
  desc "Bootstraps MySQL"
  task :mysql do        
    run "export DEBIAN_FRONTEND=noninteractive; apt-get -y install mysql-server"
    run "apt-get install libmysqlclient15-dev -y"
    run "gem install mysql -- --with-mysql-dir=/usr/include/mysql"
  end
  
  task :sqlite do
    run "gem install sqlite3-ruby"
  end
  
  task :update_cache do
    run "apt-get update"
  end
  
  task :ssaha do 
  end
  
  task :setup_ssaha_indices do 
  end
  
  task :launch_pad do
  end
  
  task :rails do
    run "gem install rails"
  end
  
  task :load_balancer do
  end
    
  task :swift do
  end
  
  task :npg do
  end
  
  task :ensembl do
  end
  
end

namespace :webapp do

  desc "Configures Apache and Passenger for a new web app"
  task :init do
    template = ERB.new File.read("lib/deploy/templates/apache-config.erb")
    prepared = template.result(binding)
    put prepared, "/etc/apache2/sites-available/#{application}"
    run "ln -s /etc/apache2/sites-available/#{application} /etc/apache2/sites-enabled/000-#{application}"
    symlink
  end
  
  task :symlink do
    run "ln -s /var/rails/#{application}/current/public /var/www/#{application}"
  end
  
  desc "Correctly sets ownership of environment.rb for Passenger"  
  task :set_ownership do
    run "chown www-data:www-data #{current_path}/config/environment.rb"    
  end
      
  task :remove_default do
    run "rm /etc/apache2/sites-enabled/000-default"
  end
  
end

namespace :deploy do
  
  desc "Restart Apache"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "/etc/init.d/apache2 restart"
  end  
 
  [:start, :stop].each do |t|
    desc "#{t} task is unnecessary with Passenger"
    task t, :roles => :app do ; end
  end
  
end