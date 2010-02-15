require File.dirname(__FILE__) + '/test_helper.rb'

require "test/unit"
class XlsHtmlCleanerTest < Test::Unit::TestCase
  def setup
    @obj = XlsHtmlCleaner.new
  end

  def test_clean!
    Dir.glob( File.dirname( __FILE__ ) + '/html/*' ) { |html|
      begin
        open( File.join( File.dirname( __FILE__ ),
                         'output',
                         File.basename( html ) ), 'wb' ) { |f|
          f.write( @obj.clean!( open( html ).read ) )
        }
        assert( true )
      rescue e
        raise e
      end
    }
  end
end
