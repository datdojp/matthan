desc 'Task to generate secret key for environments'

task :generate_secrets do
  
  logger = Logger.new(File.join(File.dirname(__FILE__), 'rake_tasks.log'))

  begin
    logger.info "===> START generate_secrets"

    secrets_file = 'config/secrets.yml'
    if File.exists?(secrets_file)
      File.delete(secrets_file)
    end

    File.open(secrets_file, 'w') do |f|
      f.write("#{Rails.env}:\n")
      f.write("  secret_key_base: #{`rake secret`}")
    end

    logger.info "<=== END generate_secrets"
  rescue => e
    logger.error e
  end
end
