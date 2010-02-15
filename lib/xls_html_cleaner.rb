require 'rubygems' unless defined? RubyGems
require 'hpricot'

class XlsHtmlCleaner
  VERSION = '0.0.2'

  ALLOW_TAGS = %w( html head title body 
                   table thead tbody tfoot tr th td col colgroup )

  def initialize
    @parser = nil
  end

  def clean!( str )
    @parser = Hpricot( str )
    @parser.traverse_all_element { |e|
      if ( e.elem? and !ALLOW_TAGS.include?( e.name.downcase ) )
        e.swap( e.inner_html.size > 0 ? e.inner_html : "\n" )
      end
      if ( e.comment? )
        e.swap( "\n" )
      end
      if ( e.elem? )
        e.attributes.to_hash.each_key { |a|
          e.remove_attribute( a )
        }
      end
    }.to_s
  end
end
