GlTail
    by Erlend Simonsen <mr@fudgie.org>
    http://www.fudgie.org

# Description:
  Real-time view of server traffic and events using OpenGL and SSH.

# Install:
  * `gem install gltail`

# Features:
  * Real-Time OpenGL view
  * Multiple logfiles on multiple servers
  * Configurable layout
  * Multiple logfile parsers
  (Apache Combined, Rails, IIS, Postfix/spamd/clamd, Nginx, Squid, PostgreSQL, PureFTPD, MySQL, TShark, qmail/vmpop3d)
  * Custom events
  * Show rate, total or average
  * If you can 'tail' it, you can visualize it
  * Written in Ruby using net-ssh & libopengl-ruby
  * Free!

# Running:
```
  gl_tail --help
  gl_tail --new gl_tail.yaml
  gl_tail
```
Options:
  You can press `f` while running to toggle the attempted frames per second. Or `b`
  to change default blob type, and space to toggle bouncing.

  To enable fullscreen mode, press `shift + f`, or set `fullscreen: true` in the config section of your `config.yaml`.

# Requirements:
  * rubygems    0.9.4
  * opengl      0.7.0.pre1
  * net-ssh     1.1.2
  * opengl/ruby development packages (ruby1.8-dev libgl1-mesa-dev libglu1-mesa-dev libglut3-dev)
  * heroku command line tools (for using Heroku as a source)
