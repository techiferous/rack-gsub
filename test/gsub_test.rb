require 'test/test_helper'

class GsubTest < Test::Unit::TestCase

  def test_no_arguments
    before_html = %Q{
      <!DOCTYPE html
      PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" 
      "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
      <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
        <head>
          <title>Testing Rack::Linkify</title>
        </head>
        <body>
          Hi, Mom!
        </body>
      </html>
    }
    after_html = process_html(before_html, Rack::Gsub)
    assert_html_equal before_html, after_html
  end

end
