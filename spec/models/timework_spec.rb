require 'rails_helper'

describe Timework, type: :model do
  def timework
    @timework ||= Timework.new  	
  end

  it 'should be valid' do
  	expect(timework.valid?).to eql(true)
  end

  context 'password with special characters' do
    it 'should build encoded uri correctly' do
      uri = Timework.build_encoded_uri('ryoe', 'myPassword1percent', 'myClientId')

      expected = "#{Timework::API_URL}/CreateSessionSelectClient?login=ryoe&password=myPassword1percent&secondFactor=&matchfield=EmployerID&ClientID=myClientId"
      actual = uri.to_s

      expect(actual).to eql(expected)
    end

    it 'should be identical to string interpolation' do
      user_id = 'ryoe'
      password = 'myPassword1percent'
      client_id = 'myClientId'

      uri = Timework.build_encoded_uri(user_id, password, client_id)

      interpolation = "#{Timework::API_URL}/CreateSessionSelectClient?login=#{user_id}&password=#{password}&secondFactor=&matchfield=EmployerID&ClientID=#{client_id}"
      actual = uri.to_s

      expect(actual).to eql(interpolation)
    end
  end

  context 'password using special characters' do
    it 'should build encoded uri correctly' do
      uri = Timework.build_encoded_uri('ryoe', 'myPassword1%', 'myClientId')

      expected = "#{Timework::API_URL}/CreateSessionSelectClient?login=ryoe&password=myPassword1%25&secondFactor=&matchfield=EmployerID&ClientID=myClientId"
      actual = uri.to_s

      expect(actual).to eql(expected)
    end

    it 'should not be identical to string interpolation' do
      user_id = 'ryoe'
      password = 'myPassword1%'
      client_id = 'myClientId'

      uri = Timework.build_encoded_uri(user_id, password, client_id)

      interpolation = "#{Timework::API_URL}/CreateSessionSelectClient?login=#{user_id}&password=#{password}&secondFactor=&matchfield=EmployerID&ClientID=#{client_id}"
      actual = uri.to_s

      expect(actual).not_to eql(interpolation)
    end
  end
  
  context 'pto api report by client' do
    it 'total of api call should equal total of csv hash' do
      user_id = ENV['TIMEWORKS_API_ADMIN_USER']
      password = ENV['TIMEWORKS_API_ADMIN_PASSWORD']
      client_id =  #how to select a valid timework.client_id?
      raw_data = Timework.pto_report_by_client(user_id, password, client_id)
      actual = EmployeeBenefit.import(raw_data) #how to sum employee_benefit.pto_balance before it is saved?
      expected = #employee_benefit.pto_balance.sum
      
      expect(actual).to eql(expected)
    end 
    
    it 'total number of companies should equal total called' do
       Company.all.each
    
    
    
    end
    
  end
end