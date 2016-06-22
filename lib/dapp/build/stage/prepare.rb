module Dapp
  module Build
    module Stage
      class Prepare < Base
        include Mod::Centos7
        include Mod::Ubuntu1404
        include Mod::Ubuntu1604

        def name
          :prepare
        end

        def image
          super do |image|
            send(_image_method, image)
            image.build_opts!({ expose: build.conf[:exposes] }) unless build.conf[:exposes].nil?
          end
        end

        def _image_method
          from = from_image_name
          :"from_#{from.to_s.split(/[:.]/).join}".tap do |from_method|
            raise "unsupported docker image '#{from}'" unless respond_to?(from_method)
          end
        end

        def from_image_name
          build.conf[:from]
        end

        def signature
          image.signature
        end
      end # Prepare
    end # Stage
  end # Build
end # Dapp