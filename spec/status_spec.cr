require "./spec_helper"

describe Status do
  describe "new" do
    it "should return Ok when 200" do
      Status.new(200).should eq(Status::Code::Ok)
    end

    it "should return Unregistered when invalid" do
      Status.new(5000).should eq(Status::Code::Unregistered)
    end
  end

  describe Status::Code do
    describe "from_code" do
      it "should return NotFound when 404" do
        Status::Code.from_code(404).should eq(Status::Code::NotFound)
      end

      it "should return Unregistered when invalid" do
        Status.new(5000).should eq(Status::Code::Unregistered)
      end
    end

    describe "from_code?" do
      it "should return ServiceUnavailable when 503" do
        Status::Code.from_code?(503).should eq(Status::Code::ServiceUnavailable)
      end

      it "should return nil when invalid" do
        Status::Code.from_code?(1000).should be_nil
      end
    end

    describe "from_code!" do
      it "should return ImATeapot when 418" do
        Status::Code.from_code!(418).should eq(Status::Code::ImATeapot)
      end

      it "should return nil when invalid" do
        expect_raises { Status::Code.from_code!(1000) }
      end
    end

    describe "message" do
      it "should return the correct message when valid" do
        Status::Code::InternalServerError.message.should eq("Internal Server Error")
      end

      it "should return the empty string when invalid" do
        Status::Code::Unregistered.message.should eq("")
      end
    end

    describe "to_i" do
      it "should return the underlying integer" do
        Status::Code::MethodNotAllowed.to_i.should eq(405)
      end
    end

    describe "informational?" do
      it "should be true for Continue" do
        Status::Code::Continue.informational?.should be_true
      end

      it "should be false for Ok" do
        Status::Code::Ok.informational?.should be_false
      end
    end

    describe "success?" do
      it "should be true for NoContent" do
        Status::Code::NoContent.success?.should be_true
      end

      it "should be false for Conflict" do
        Status::Code::Conflict.success?.should be_false
      end
    end

    describe "redirection?" do
      it "should be true for Found" do
        Status::Code::Found.redirection?.should be_true
      end

      it "should be false for Forbidden" do
        Status::Code::Forbidden.redirection?.should be_false
      end
    end

    describe "client_error?" do
      it "should be true for MethodNotAllowed" do
        Status::Code::MethodNotAllowed.client_error?.should be_true
      end

      it "should be false for Accepted" do
        Status::Code::Accepted.client_error?.should be_false
      end
    end

    describe "server_error?" do
      it "should be true for ServiceUnavailable" do
        Status::Code::ServiceUnavailable.server_error?.should be_true
      end

      it "should be false for Gone" do
        Status::Code::Gone.server_error?.should be_false
      end
    end
  end
end
