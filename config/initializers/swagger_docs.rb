# frozen_string_literal: true

Swagger::Docs::Config.register_apis('1.0' => {
                                      # the output location where your .json files are written to
                                      api_file_path: 'public',
                                      # the URL base path to your API
                                      base_path: if Rails.env.development?
                                                   'http://localhost:3000'
                                                 else
                                                   'https://thawing-oasis-83740.herokuapp.com'
                                                 end,

                                      # if you want to delete all .json files at each generation
                                      clean_directory: true,
                                      # add custom attributes to api-docs
                                      attributes: {
                                        info: {
                                          'title' => 'An Online Pizzeria',
                                          'description' => 'Order Pizza and have it at the comfort of your home'
                                        }
                                      }
                                    })
