module GlTail
  class Color
    
    # Rewrite color in opengl format
    def self.is(v)
      value = COLORS[v.downcase]
      unless value
        raise SyntaxError, "You must use either [#{COLORS.keys.sort.join('|')}] or a color in RGBA format."
      end
    
      values = value.map { |x| x.to_i / 255.0 }
    end

    def self.list_colors
      COLORS.keys
    end

  end
end