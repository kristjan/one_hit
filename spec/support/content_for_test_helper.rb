module ContentForTestHelper
   def content_for(name)
     HTML::Document.new(view.instance_variable_get('@_content_for')[name]).root
   end
end
