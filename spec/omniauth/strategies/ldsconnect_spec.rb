require 'spec_helper'

describe OmniAuth::Strategies::Ldsconnect do
  let(:access_token) { stub('AccessToken', :options => {}) }
  let(:parsed_response) { stub('ParsedResponse') }
  let(:response) { stub('Response', :parsed => parsed_response) }

  subject do
    OmniAuth::Strategies::Ldsconnect.new({})
  end

  before(:each) do
    subject.stub!(:access_token).and_return(access_token)
  end

  context "client options" do
    it 'should have correct site' do
      subject.options.client_options.site.should eq("https://ldsconnect.org")
   end

    it 'should have correct authorize_url ' do
      subject.options.client_options.authorize_url.should eq("/dialog/authorize")
    end

    it 'should have correct token_url  ' do
      subject.options.client_options.token_url.should eq("/oauth/token")
    end
  end

  context "access token options" do
    it 'should have correct header_format' do
      subject.options.access_token_options.header_format eq("OAuth %s")
    end

    it 'should have correct param_name ' do
      subject.options.access_token_options.param_name.should eq("access_token")
    end
  end
end
