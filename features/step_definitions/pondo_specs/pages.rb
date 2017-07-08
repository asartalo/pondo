module PondoSpecs
  module Pages
    module_function


    {
      home: {
        path: '/'
      },

      dashboard: {
        path: '/dashboard'
      },

      # NITRONLINKS TESTING ONLY
      nitrolinks: {
        path: '/nitrolinks',
        content: 'Nitrolinks Testing Home'
      },

      nitrolinks_debugging: {
        path: '/nitrolinks#nitro-debugging',
        content: 'Nitrolinks Testing Home'
      },

      nitrolinks_hash: {
        path: '/nitrolinks#',
        content: 'Nitrolinks Testing Home'
      },

      nitrolinks_1: {
        path: '/nitrolinks/link1',
        content: 'Link 1'
      },

      redirected: {
        path: '/nitrolinks/redirected',
        content: 'Redirected'
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

