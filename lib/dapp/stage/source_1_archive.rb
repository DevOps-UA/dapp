module Dapp
  module Stage
    class Source1Archive < Base
      def image
        super do |image|
          builder.git_artifact_list.each do |git_artifact|
            git_artifact.apply_archive!(image)
          end
        end

        def signature
          hashsum builder.stages[:infra_install].signature
        end
      end
    end # Source1Archive
  end # Stage
end # Dapp