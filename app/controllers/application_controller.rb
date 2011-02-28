class ApplicationController < ActionController::Base
  protect_from_forgery

  TEXT_FORMATS = %w[json xml].map(&:to_sym)

private

  def text_formats(format, data=nil, options={})
    TEXT_FORMATS.each do |encoding|
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
