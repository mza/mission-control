class StatusUpdater
  
  def self.update(sqs)
    
    messages = sqs.queue('eventqueue')
    progress = sqs.queue('progressqueue')
    
    if messages.size > 0
      for i in 0..messages.size
        message = messages.pop
        Job.update message
      end
    end
    
    if progress.size > 0
      for i in 0..progress.size
        message = progress.pop
        Progress.update message
      end
    end
    
  end
  
end