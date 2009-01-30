module VehicleAssembly
  class Parser
    
    def self.parse(filename)
      template = ERB.new File.read(filename)
      template.result(binding)
    end
          
  end
end