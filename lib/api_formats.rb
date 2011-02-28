module ApiFormats
  API_FORMATS = %w[json xml].map(&:to_sym).freeze

  def self.included(base)
    base.send :private, :api_formats
  end

  def api_formats(format, data=nil, options={})
    API_FORMATS.each do |encoding|
      format.send(encoding) do
        if block_given?
          yield
        else
          render options.merge(encoding => data)
        end
      end
    end
  end
end
