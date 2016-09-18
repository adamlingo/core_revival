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
end