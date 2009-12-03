require 'rack-plastic'

module Rack
  class Gsub < Plastic
 
    def change_nokogiri_doc(doc)
      doc.at_css("body").traverse do |node|
        if node.text?
          options.each do |pattern, replacement|
            update_text(node, node.content.gsub(pattern, replacement))
          end
        end
      end
      doc
    end
    
  end
end
