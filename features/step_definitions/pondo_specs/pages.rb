module PondoSpecs
  module Pages
    module_function

    {
      home: {
        path: '/'
      },

      welcome: {
        path: '/welcome'
      },

    }.each do |page_name, data|
      define_method :"#{page_name}_page" do
        data[:path]
      end

      define_method :"#{page_name}_page_content" do
        data[:content]
      end
    end

  end
end

