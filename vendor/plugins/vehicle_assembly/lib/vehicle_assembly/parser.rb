module VehicleAssembly
  class Parser
    
    def self.parse(filename)
      template = ERB.new File.read(filename)
      template.result(binding)
    end

    def self.prepare(filename, options = {})
      file = options[:for]
      unless File.exists? file
        File.open(file, 'w') do |f|
          f.write VehicleAssembly::Parser.parse(filename)
        end
      else
        puts "File '#{file}' exists and will not be overwritten."
      end
    end
    
  end
end