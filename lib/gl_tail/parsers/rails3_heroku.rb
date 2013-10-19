# gl_tail.rb - OpenGL visualization of your server traffic
# Copyright 2007 Erlend Simonsen <mr@fudgie.org>
#
# Licensed under the GNU General Public License v2 (see LICENSE)
#

# Parser which handles Rails 3 access logs
class Rails3HerokuParser < Parser
  def parse( line )
    if line =~ /Started (GET|POST|PUT|DELETE) "(.*)" for (\d+\.\d+\.\d+\.\d+) at .*$/
      add_activity(:block => 'content', :name => 'page')
      add_activity(:block => 'users', :name => $3)
      add_activity(:block => 'urls', :name => HttpHelper.generalize_url($2))
      if line =~ /app\[(web.+)\]: .+/
        add_activity(:block => 'dynos', :name => $1)
      end
    end
  end
end