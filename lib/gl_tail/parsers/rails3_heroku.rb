# gl_tail.rb - OpenGL visualization of your server traffic
# Copyright 2007 Erlend Simonsen <mr@fudgie.org>
#
# Licensed under the GNU General Public License v2 (see LICENSE)
#

# Parser which handles Rails 3 access logs
class Rails3HerokuParser < Parser
  def parse( line )
    if line=~ /heroku\[router\]: at=.+ method=(?<method>GET|POST|PUT|DELETE) path=(?<path>.*) host=.* fwd=(?<fwd>.*) dyno=(?<dyno>.*) connect=.* service=.* status=.* bytes=(?<bytes>.*)/
      
      bytes = $~[:bytes].to_f
      path = HttpHelper.generalize_url($~[:path])
      fwd = $~[:fwd].tr('"', '') # Strip quotes
      dyno = $~[:dyno]
      dyno_num = /\d/.match($~[:dyno]).to_s.to_i


      # add_activity(:block => 'content', :name => 'page', :size => bytes, :color => dyno_color(dyno_num))
      # add_activity(:block => 'urls', :name => path)
      add_activity(:block => 'dynos', :name => dyno, :size => bytes, :color => dyno_color(dyno_num))
      # add_activity(:block => 'users', :name => fwd)
    end
  end

  def dyno_color(dyno_num)
    keys = GlTail::Color.list_colors

    key = keys.at(dyno_num)

    GlTail::Color.is(key)
  end

end