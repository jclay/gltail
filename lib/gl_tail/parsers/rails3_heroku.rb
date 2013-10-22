# gl_tail.rb - OpenGL visualization of your server traffic
# Copyright 2007 Erlend Simonsen <mr@fudgie.org>
#
# Licensed under the GNU General Public License v2 (see LICENSE)
#

# Parser which handles Rails 3 access logs
class Rails3HerokuParser < Parser
  def parse( line )
    if line=~ /heroku\[router\]: at=.+ method=(?<method>GET|POST|PUT|DELETE) path=(?<path>.*) host=.* fwd=(?<fwd>.*) dyno=(?<dyno>.*) connect=.* service=.* status=.* bytes=(?<bytes>.*)/
      fwd = $~[:fwd].tr('"', '') # Strip quotes

      add_activity(:block => 'content', :name => 'page', :size => $~[:bytes].to_f)
      add_activity(:block => 'urls', :name => HttpHelper.generalize_url($~[:path]))
      add_activity(:block => 'dynos', :name => $~[:dyno])
      add_activity(:block => 'users', :name => fwd)
    end
  end
end