settings = YAML.load(File.open("#{Rails.root}/config/aws.yml")).symbolize_keys
sqs = RightAws::SqsGen2.new(settings[:access_key_id], settings[:secret_access_key])

loop do
  StatusUpdater.update sqs
  sleep 3
end
