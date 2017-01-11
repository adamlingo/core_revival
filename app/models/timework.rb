require 'net/http'
require 'date'

class Timework < ActiveRecord::Base
    belongs_to :company

    API_URL = 'https://www.swipeclock.com/pg/api12.asmx'.freeze

    def self.build_encoded_uri(user_id, password, client_id)
        request_url = "#{API_URL}/CreateSessionSelectClient"
        query_params = [
            ['login', user_id],
            ['password', password],
            ['secondFactor', ''],
            ['matchfield', 'EmployerID'],
            ['ClientID', client_id]
        ]
        uri = URI.parse(request_url)
        uri.query = URI.encode_www_form(query_params)
        uri
    end

    def self.createSession(user_id, password, client_id)
        uri = build_encoded_uri(user_id, password, client_id)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true

        req = Net::HTTP::Get.new(uri)
        res = http.request(req)

        h = Hash.from_xml(res.body)
        h['CreateSessionResult']['SessionID']       
    end

    def self.pto_report_by_client(user_id, password, client_id)
        session_id = Timework.createSession(user_id, password, client_id)
        puts session_id
        date = Date.today
        begin_date = date.beginning_of_year
 
        request_url = "#{API_URL}/GetActivityFile"
        query_params = [
            ['sessionID', session_id],
            ['BeginDate', begin_date.strftime('%Y-%m-%d')],
            ['EndDate', date.strftime('%Y-%m-%d')],
            ['FormatName', 'swipeclockpto'],
            ['OptionalLaborMapping','']
        ]

        uri = URI.parse(request_url)
        uri.query = URI.encode_www_form(query_params)

        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true

        req = Net::HTTP::Get.new(uri)
        res = http.request(req)

        h = Hash.from_xml(res.body)
        # return the CSV data
        h['GetActivityFileApiResult']['FormatText']       
    end


end


# this is a change #