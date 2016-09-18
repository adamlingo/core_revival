require "test_helper"

class TimeworkTest < ActiveSupport::TestCase

  def timework
    @timework ||= Timework.new
  end

  test 'valid' do
    assert timework.valid?
  end

  test 'build_encoded_uri without special characters' do
    uri = Timework.build_encoded_uri('ryoe', 'myPassword1percent', 'myClientId')

    expected = "#{Timework::API_URL}/CreateSessionSelectClient?login=ryoe&password=myPassword1percent&secondFactor=&matchfield=EmployerID&ClientID=myClientId"
    actual = uri.to_s

    assert_equal expected, actual
  end

  test 'when not using special characters, build_encoded_uri IS SAME as string interpolation' do
    user_id = 'ryoe'
    password = 'myPassword1percent'
    client_id = 'myClientId'

    uri = Timework.build_encoded_uri(user_id, password, client_id)

    interpolation = "#{Timework::API_URL}/CreateSessionSelectClient?login=#{user_id}&password=#{password}&secondFactor=&matchfield=EmployerID&ClientID=#{client_id}"
    actual = uri.to_s

    assert_equal interpolation, actual
  end

  test 'build_encoded_uri password has special characters' do
    uri = Timework.build_encoded_uri('ryoe', 'myPassword1%', 'myClientId')

    expected = "#{Timework::API_URL}/CreateSessionSelectClient?login=ryoe&password=myPassword1%25&secondFactor=&matchfield=EmployerID&ClientID=myClientId"
    actual = uri.to_s

    assert_equal expected, actual
  end

  test 'when using special characters, build_encoded_uri IS NOT SAME as string interpolation' do
    user_id = 'ryoe'
    password = 'myPassword1%'
    client_id = 'myClientId'

    uri = Timework.build_encoded_uri(user_id, password, client_id)

    interpolation = "#{Timework::API_URL}/CreateSessionSelectClient?login=#{user_id}&password=#{password}&secondFactor=&matchfield=EmployerID&ClientID=#{client_id}"
    actual = uri.to_s

    assert_not_equal interpolation, actual
  end

end
