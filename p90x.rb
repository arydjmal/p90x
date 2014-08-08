class P90X < Sinatra::Base
  register Sinatra::ConfigFile

  config_file 'config.yml'

  get '/' do
    erb :index
  end

  get '/calendar.ics' do
    program = params[:program]
    routine = params[:routine]
    start_date = Date.parse(params[:start_date])
    content_type 'text/calendar'
    "BEGIN:VCALENDAR
VERSION:2.0
PRODID:-//Natural Bits//P90X iCal Generator//EN
NAME:#{program} - #{routine}
X-WR-CALNAME:#{program} - #{routine}" +
settings.programs[program][routine].map { |day, workout|
  "
BEGIN:VEVENT
DTSTART;VALUE=DATE:#{(start_date+day.to_i-1).strftime("%Y%m%d")}
DTEND;VALUE=DATE:#{(start_date+day.to_i).strftime("%Y%m%d")}
SUMMARY:Day #{day}: #{workout}
END:VEVENT"
  }.join('') +
"
END:VCALENDAR"
  end
end
