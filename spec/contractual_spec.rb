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
  
    lambda { mock_object.mock_operation }.should raise_error(Contractual::Interface::MethodNotImplementedError, "MockInterfaceImpl needs to implement 'mock_operation' for interface MockInterface!")

    lambda { mock_object.perform_another_mock_operation }.should raise_error(Contractual::Interface::MethodNotImplementedError, "MockInterfaceImpl needs to implement 'perform_another_mock_operation' for interface MockInterface!")
  
  end
end