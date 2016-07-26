class Timeworks 

  #DEFAULT_HOURS_PER_WEEK = 40
  #DEFAULT_VACATION_DAYS_PER_YEAR = 10

  attr_accessor :user, :password, :sync_account, :default_hours_per_week
  attr_accessor :default_vacation_days_per_year, :start_date, :end_date

  #def initialize(options)
   # super(options)
    #@sync_account_id = options[:sync_account_id]
    #@sync_account = SyncAccount.find_by_id(@sync_account_id)
    #@user = @sync_account.site_user_name
    #@password = @sync_account.site_user_password
    #@start_date = options[:start_date]
    #@end_date = options[:end_date]
    #company  = Company.find_by_id(options[:company_id])
    #get_employees_in_need_to_export(company)
  #end

  #def import_employees
   # getEmployees
    #load_data
    #compute_data
    #compute_employees
    #compute_salaries
    #compute_timesheets
  #end

  #def export_employees
    # need similar method to connect swipeclock login functionality... but may want to
    # consider moving this Client connection to app/services first to have universal URL call
   # client = Savon::Client.new(wsdl: "http://www.swipeclock.com/pg/api12.asmx?wsdl")
    #sesID = Timeworks::createSession(@user, @password)
    #employees = transform_employees_to_soap(@employees_to_be_exported)
    #if employees.present?
     # response  = client.call(:update_employee_fields,message: {sessionID: sesID.to_s, "AddIfNotFound"=> "false", "IdentityField"=> "UNIQUEID","Employees"=> employees})
    #end
 #end

  def self.createSession(user, pass)
    require 'net/http'
    request_url = 'http://www.swipeclock.com/pg/api12.asmx/CreateSession?login='+user+'&password='+pass+'&secondFactor= '
    url = URI.parse(request_url)
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    h = Hash.from_xml(res.body)
    sesID = h['CreateSessionResult']['SessionID']
    return sesID
  end

  # def getEmployees
  #  require 'net/http'
  #  sesID = Timeworks::createSession(@user, @password)
  #  urlString = 'http://www.swipeclock.com/pg/api12.asmx/GetUnfinalizedPayroll?sessionID='+sesID+'&BeginDate='+@start_date.to_s+'&EndDate='+@end_date.to_s
  #  urlSelect = URI.parse(urlString)
  #  reqSelect = Net::HTTP::Get.new(urlSelect.to_s)
  #  resSelect = Net::HTTP.start(urlSelect.host, urlSelect.port) {|http|
  #   http.request(reqSelect)
  #   }
  #  parseXML(resSelect.body)
  # end

  #def parseXML(body)
   # xml_doc  = Nokogiri::XML(body)
  #  timecard = xml_doc.xpath("//TimeCard")
    # x = xml_doc.xpath("//Employee")

   # timecard.each_with_index do |e, pos|
    #  employee = e.at_xpath("Employee")
    #  summary = e.at_xpath("Summary")
    #  dates = e.xpath("Lines/TimeCardLine")
    #  @array_rows << {
    #    unique_id: employee["UniqueID"],
    #    last_name: employee["LastName"],
    #    first_name: employee["FirstName"],
    #    email: employee.at_xpath("Email").text,
    #    hourly_rate: employee.search("[@name='PayRate0']").text,
    #    date_of_birth: employee.search("[@name='Birthday']").text,
    #    hours_per_week: @default_hours_per_week,
    #    date_of_hire: employee.at_xpath("StartDate").text,
    #    timecardlines: get_date_lines(dates),
    #    summary: get_summary(summary)
    #  }
    #end
  #end

  #def transform_employees_to_soap(employees)
   # array = []
    #employees.each do |e|
    #  hash = {}
    #  arr = [ {"FieldToUpdate"=> { "FieldName"=> "LastName", "Value"=> e.last_name }} ,
    #          {"FieldToUpdate"=> { "FieldName"=> "FirstName", "Value"=> e.first_name }},
    #          {"FieldToUpdate"=> { "FieldName"=> "Email", "Value"=> e.email }},
    #          {"FieldToUpdate"=> { "FieldName"=> "Birthday", "Value"=> e.date_of_birth }},
    #          {"FieldToUpdate"=> { "FieldName"=> "StartDate", "Value"=> e.date_of_hire }}]
    #  hash["EmployeeFieldsToUpdate"] = {"FieldsToUpdate"=> arr, "Identifier"=> e.unique_id}
    #  array << hash
    #end
    #return array
  #end

  #def get_employees_in_need_to_export(company)
   # company.last_timeworks_export.present? ? last_export = company.last_timeworks_export : last_export = Time.now - 100.years
  #  company.last_timeworks_import.present? ? last_import = company.last_timeworks_import : last_import = Time.now - 100.years
   # if last_export > last_import
    #  exp_employees = company.employees.where("updated_at > ?", last_export)
      #exp_employees = company.employees.where("updated_at > ? OR created_at > ?", last_export, last_export)
    #else
     # exp_employees = company.employees.where("updated_at > ?", last_import)
      #exp_employees = company.employees.where("updated_at > ? OR created_at > ?", last_import, last_export)
  #  end

    # exp_employees_by_salaries = company.employees.select{|x| x if x.get_current_salary.present? && \
    #                                                               (x.get_current_salary.updated_at > company.last_timeworks_import || \
    #                                                               x.get_current_salary.created_at > company.last_timeworks_import )}
   # @employees_to_be_exported = exp_employees
  #end

  #def get_date_lines(dates)
   # date_lines = []
    # regular       => BaseCategory
    # overtime      => OT1Category
    # doubletime    => OT2Category
    # unpaid        => UnpaidCategory
    #dates.each do |d|
    #  date_lines << {
    #    event_date: d.at_xpath("SuggestedAnchorDate").text.to_date,
    #    timecardlinekind: d["TimeCardLineKind"],
    #    basecategory: d["BaseCategory"],
    #    seconds: d["Seconds"].to_i,
    #    unpaid_seconds: d["UnpaidSeconds"],
    #    nonotseconds: d["NonOTSeconds"].to_i,
    #    overtime_seconds: d["OT1Seconds"].to_i,
    #    doubletime_seconds: d["OT2Seconds"].to_i,
    #    scheduledseconds: d["ScheduledSeconds"].to_i
    #  }
    #end
    #return date_lines
  #end

  #def get_summary(summary)
   # totalbase = summary.at_xpath("Lines/SummaryLine")
  #  summary = {}
  #  summary = {
  #    base_seconds: totalbase.at_xpath("TotalBaseSeconds").text.to_i,
  #    unpaid_seconds: totalbase.at_xpath("TotalUnpaidSeconds").text.to_i,
  #    overtime_seconds: totalbase.at_xpath("TotalOT1Seconds").text.to_i,
  #    doubletime_seconds: totalbase.at_xpath("TotalOT2Seconds").text.to_i
  #  } if totalbase.present?
  #  return summary
  #end

  #def compute_timesheets
   # return if @payroll_schedule.blank?
  #  @create_timesheets = []
   # @update_timesheets = []
  #  @array_rows.each do |row|
  #    unique_id = row[:unique_id].to_i
  #    employee_id = search_existing_employee_id(unique_id)
  #    timesheet = @hash_employee_unique_id_timesheets[unique_id] if @hash_employee_unique_id_timesheets[unique_id].present?
  #    timesheet = @hash_employee_id_timesheets[employee_id] if employee_id.present? && @hash_employee_id_timesheets[employee_id].present? && timesheet.blank?
  #    timesheet = Timesheet.new(
  #      payroll_schedule_id: @payroll_schedule.id,
  #      employee_id: employee_id,
  #      company_id: @company.id
  #    ) if timesheet.blank?
  #    if row[:summary].present?
  #      timesheet.hours = calc_hours(row[:summary][:base_seconds]) if row[:summary][:base_seconds].present?
  #      timesheet.overtime = calc_hours(row[:summary][:overtime_seconds]) if row[:summary][:overtime_seconds].present? && row[:summary][:overtime_seconds] > 0
  #      @create_timesheets << timesheet if timesheet.id.blank?
  #      @update_timesheets << timesheet if timesheet.id.present?
  #    end
  #  end
    #Timesheet.import @create_timesheets if @create_timesheets.present?
    #if @update_timesheets.present?
   #   timesheet_columns = ExportColumns::TIMESHEET_COLUMNS + [:updated_at]
  #    UpsertLib.upsert_table(@update_timesheets, timesheet_columns, "timesheets")
   # end
  #end

  #def calc_hours(seconds)
  #  hours = (seconds - (seconds % 60)) / 3600
  #  minutes = (((seconds % 60) * 100) / 60) / 100
  #  result = hours + minutes
  #  return result.to_f
  #end

  #def search_existing_employee_id(unique_id)
  #  @hash_employees[unique_id].present? ? @hash_employees[unique_id].id : nil
 # end
end
