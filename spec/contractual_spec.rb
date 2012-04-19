require 'contractual'

describe Contractual::Interface, "an interface should support a contract" do
  
  class MockInterface
    include Contractual::Interface
    
    must_implement :mock_operation
    must :perform_another_mock_operation
    
  end

  class MockInterfaceImpl < MockInterface; end


  it "should warn about unimplemented methods" do
    mock_object = MockInterfaceImpl.new
  
    lambda { mock_object.mock_operation }.should raise_error(Contractual::Interface::MethodNotImplementedError, "MockInterfaceImpl is obligated to implement 'mock_operation' for interface MockInterface!")

    lambda { mock_object.perform_another_mock_operation }.should raise_error(Contractual::Interface::MethodNotImplementedError, "MockInterfaceImpl is obligated to implement 'perform_another_mock_operation' for interface MockInterface!")
  
  end
  
  
  class Vehicle
    include Contractual::Interface

    must :load, :passengers
    must :follow, :route
    must :unload, :passengers
    
    class Route; end

    def take(passengers, destination)
      @passengers = []
      load passengers
      follow Route.new(@current_location, destination)
      unload passengers
    end
  end
  
  class Zeppelin < Vehicle
    def load(passengers); @passengers << passengers; end
    def unload(passengers); @current_location << passengers; @passengers = []; end
  end
  
  it "should warn about unimplemented methods with arguments" do
    zeppelin = Zeppelin.new
    us, anywhere = nil, nil
    lambda { zeppelin.take(us, anywhere) }.should raise_error(Contractual::Interface::MethodNotImplementedError, "Zeppelin is obligated to implement 'follow' for interface Vehicle!")
  end
end