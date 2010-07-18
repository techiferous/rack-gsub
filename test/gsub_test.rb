require 'test/test_helper'

class GsubTest < Test::Unit::TestCase

  def test_no_arguments
    before_html = %Q{
      <!DOCTYPE html
      PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" 
      "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
      <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
        <head>
          <title>Testing Rack::Gsub</title>
        </head>
        <body>
          Hi, Mom!
        </body>
      </html>
    }
    after_html = process_html(before_html, Rack::Gsub)
    assert_html_equal before_html, after_html
  end

  def test_basic_replace
    before_html = %Q{
      <!DOCTYPE html
      PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" 
      "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
      <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
        <head>
          <title>Testing Rack::Gsub</title>
        </head>
        <body>
          In Soviet Russia, there is censorship.
        </body>
      </html>
    }
    expected_html = %Q{
      <!DOCTYPE html
      PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" 
      "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
      <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
        <head>
          <title>Testing Rack::Gsub</title>
        </head>
        <body>
          In Soviet Russia, there is no censorship.
        </body>
      </html>
    }
    after_html = process_html(before_html, Rack::Gsub, "censorship" => "no censorship")
    assert_html_equal expected_html, after_html
  end

  def test_multiple_replace
    before_html = %Q{
      <!DOCTYPE html
      PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" 
      "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
      <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
        <head>
          <title>Testing Rack::Gsub</title>
        </head>
        <body>
          In Soviet Russia, there is censorship.
        </body>
      </html>
    }
    expected_html = %Q{
      <!DOCTYPE html
      PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" 
      "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
      <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
        <head>
          <title>Testing Rack::Gsub</title>
        </head>
        <body>
          In SovXXt RussXa, thXrX Xs cXnsorshXp.
        </body>
      </html>
    }
    after_html = process_html(before_html, Rack::Gsub, "i" => "X", "e" => "X")
    assert_html_equal expected_html, after_html
  end

  def test_regex_replace
    before_html = %Q{
      <!DOCTYPE html
      PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" 
      "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
      <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
        <head>
          <title>Testing Rack::Gsub</title>
        </head>
        <body>
          I'm getting better!
          No, you're not.  You'll be stone dead in a moment.
          Oh, I can't take him like that; it's against regulations.
          I don't want to go in the cart!
          Oh, don't be such a baby.
          I can't take him...
          I feel fine!
        </body>
      </html>
    }
    expected_html = %Q{
      <!DOCTYPE html
      PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" 
      "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
      <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
        <head>
          <title>Testing Rack::Gsub</title>
        </head>
        <body>
          I'm getting better!
          No, you're not.  You'll be stone dead in a moment.
          Oh, I can't take him like th**; it's against regul**ions.
          I don't want to go in the c**t!
          Oh, don't be such a baby.
          I can't take him...
          I feel fine!
        </body>
      </html>
    }
    after_html = process_html(before_html, Rack::Gsub, /a[t,r]/ => '**')
    assert_html_equal expected_html, after_html
  end

  def test_case_insensitive_regex_replace
    before_html = %Q{
      <!DOCTYPE html
      PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" 
      "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
      <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
        <head>
          <title>Testing Rack::Gsub</title>
        </head>
        <body>
          one ONE One
          two TWO Two
          three THREE Three
          four FOUR Four
        </body>
      </html>
    }
    expected_html = %Q{
      <!DOCTYPE html
      PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" 
      "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
      <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
        <head>
          <title>Testing Rack::Gsub</title>
        </head>
        <body>
          1 ONE One
          two TWO Two
          3 3 3
          four FOUR Four
        </body>
      </html>
    }
    after_html = process_html(before_html, Rack::Gsub, /one/ => '1', /three/i => '3')
    assert_html_equal expected_html, after_html
  end

end
