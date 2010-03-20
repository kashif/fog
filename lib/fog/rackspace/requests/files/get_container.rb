module Fog
  module Rackspace
    module Files
      class Real

        # Get details for container and total bytes stored
        #
        # ==== Parameters
        # * container<~String> - Name of container to retrieve info for
        # * options<~String>:
        #   * 'limit'<~String> - Maximum number of objects to return
        #   * 'marker'<~String> - Only return objects whose name is greater than marker
        #   * 'prefix'<~String> - Limits results to those starting with prefix
        #   * 'path'<~String> - Return objects nested in the pseudo path
        #
        # ==== Returns
        # * response<~Excon::Response>:
        #   * headers<~Hash>:
        #     * 'X-Account-Container-Count'<~String> - Count of containers
        #     * 'X-Account-Bytes-Used'<~String> - Bytes used
        #   * body<~Array>:
        #     * 'bytes'<~Integer> - Number of bytes used by container
        #     * 'count'<~Integer> - Number of items in container
        #     * 'name'<~String> - Name of container
        #     * item<~Hash>:
        #       * 'bytes'<~String> - Size of object
        #       * 'content_type'<~String> Content-Type of object
        #       * 'hash'<~String> - Hash of object (etag?)
        #       * 'last_modified'<~String> - Last modified timestamp
        #       * 'name'<~String> - Name of object
        def get_container(container, options = {})
          query = ''
          for key, value in options.merge!({ 'format' => 'json' })
            query << "#{key}=#{value}&"
          end
          query.chop!
          response = storage_request(
            :expects  => 200,
            :method   => 'GET',
            :path     => container,
            :query    => query
          )
          response
        end

      end

      class Mock

        def get_container(container, options = {})
          raise MockNotImplemented.new("Contributions welcome!")
        end

      end
    end
  end
end
