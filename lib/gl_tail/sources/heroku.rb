require 'pty'
require 'tmpdir'

module GlTail
  module Source
    class Heroku < Base
      config_attribute :source, "The type of Source"
      config_attribute :app, "The heroku app to monitor"

      def init
        # Setup tmp file to cache heroku log
        open_log_file

        # Stream heroku log
        open_heroku_log

        # Wait until the log file has been created before proceeding
        # Only display waiting message once
        loop_count = 0 
        while !File.exists?(@tmp_log_path)
          puts "Waiting for file to exist..." if loop_count < 1
          loop_count += 1
        end

        @log = File.open(@tmp_log_path, 'r')
        @log.extend(File::Tail)
        @log.max_interval = 5
        @log.return_if_eof = true

        # Do some cleanup and delete the cache file
        at_exit do
          File.delete(@tmp_log_path)
        end

      end

      def open_log_file
        # get a tmp dir to cache heroku log
        tmp_dir = Dir.tmpdir
        @tmp_log_path = File.join(tmp_dir, "heroku_#{app}_log.log")

        puts "[Heroku Log Path]: #{@tmp_log_path}"
      end

      def process
        @log.tail(1) { |line|
          parser.parse(line) 
        }
      end

      def update
      end

      # Spawn a thread streams the heroku log into a local log file
      # that is tail'd and processed later.
      def open_heroku_log
        # Uses heroku command line tools to tail a log and redirect output
        # to a tmp path
        cmd = "bundle exec heroku logs -a #{app} -p router --tail > #{@tmp_log_path}" 

        pid = Process.spawn(cmd)

        at_exit do
          Process.kill("INT", 0) # Interrupt current process. Also interrupts the spawned process.
          Process.wait(pid)
        end

      end

    end
  end
end
