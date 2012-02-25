#!/usr/bin/env ruby

#http://www.tobinharris.com/past/2010/5/10/analyse-your-git-log-with-ruby/
#http://www.jukie.net/bart/blog/pimping-out-git-log
# log --graph --pretty=format:'%C(yellow)<%an> -%C(red)%d%Creset %s %Cgreen(%cr) %Creset' --abbrev-commit --date=relative

class String
    def red; colorize(self, "\e[1m\e[31m"); end
    def green; colorize(self, "\e[1m\e[32m"); end
    def dark_green; colorize(self, "\e[32m"); end
    def yellow; colorize(self, "\e[1m\e[33m"); end
    def blue; colorize(self, "\e[1m\e[34m"); end
    def dark_blue; colorize(self, "\e[34m"); end
    def pur; colorize(self, "\e[1m\e[35m"); end
    def colorize(text, color_code)  "#{color_code}#{text}\e[0m" end
end


def check_vmc_existing
   raise "'vmc' command not found. pls run 'sudo gem install vmc' or switch to right gemset
   \n If you have ran gem install, then you need echo export
    PATH=$PATH:path/to/bin/vmc".red unless (system "vmc -v")
end

def target_cloud_foundry
  raise 'pls check out your internet connection.'.red unless system 'vmc target api.cloudfoundry.com'
end


def vmc_login
  puts "input 'pengj0520@gmail' for email in login....".yellow
  raise 'pls check out your internet connection.'.red unless system 'vmc login'
end

def vmc_apps_status
  raise 'pls check out your internet connection.'.red unless system 'vmc apps'
end

def lastest_commit_number
  topest_log = "git log -1  --pretty=format:'%H'"
  result = `#{topest_log}`
end

def vmc_update
  puts
  puts "------------------------------------------------------------------------"
  puts "[ updating project 'aWalls' hosted in cloud foundry.................. ]".yellow
  raise 'there is problem when updating cloud foundry project.'.red unless system "vmc update aWalls"
  puts "[ updating succeed]".green
  puts ":)".green
end

check_vmc_existing
target_cloud_foundry
vmc_login
vmc_apps_status
vmc_update
