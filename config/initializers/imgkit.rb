    # might get rid of this
    IMGKit.configure do |configuree|
      configuree.wkhtmltoimage = Rails.root.join('bin', 'wkhtmltoimage-amd64').to_s if ENV['RACK_ENV'] == 'production' || ENV['RACK_ENV'] == 'test'
    end
