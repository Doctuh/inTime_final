class ShiftSearch
    
    attr_reader :date_from, :date_to
    
    def initialize(params)
        params ||= {}
        @date_from = parsed_date(params[:date_from], 7.days.ago.to_date.strftime("%d/%m/%y").to_s)
        @date_to = parsed_date(params[:date_to], Date.today.strftime("%d/%m/%y").to_s)
    end

    def scope
        Shift.where('check_in_date BETWEEN ? AND ? or check_out_date BETWEEN ? AND ?', @date_from, @date_to, @date_from, @date_to)
    end

    
    private

    def parsed_date(date_string, default)
        return Date.parse(date_string).strftime("%y/%m/%d")
    rescue ArgumentError, TypeError
        default
    end

end
