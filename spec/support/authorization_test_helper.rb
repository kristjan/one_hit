module AuthorizationTestHelper
  def log_in_as(user)
    controller.stub(:viewer).and_return(user)
  end

  def log_in_as_guest
    controller.stub(:viewer).and_return(nil)
  end
end
