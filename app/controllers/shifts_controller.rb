class ShiftsController < ApplicationController
    
    def new
        @shift = Shift.new
    end
    

    def create
        @worker = Worker.find(shift_params[:worker_id])
        @shift = Shift.new(shift_params)

        if @worker.shifts.any?
            if params[:"ind"] == 'Tjek ind' && @worker.shifts.last.check_out_date != nil
                @shift.check_in_full_date = Time.now.strftime("%d/%m/%y")
                @shift.check_in_date = Time.now.strftime("%d/%m/%y")
                @shift.check_in_time = Time.now.strftime("%H:%M:%S")
                @shift.check_in_weekday = get_day
                if @shift.save
                    flash[:notice] = "Du er nu scannet ind!"
                    redirect_to root_path
                else
                    render 'new'
                end
            elsif params[:"ind"] == 'Tjek ind' && @worker.shifts.last.check_out_date == nil
                flash[:alert] = "Du er allerede scannet ind, scan ud for at fortsætte!"
                redirect_to root_path
            end
        else
            @shift.check_in_date = Time.now.strftime("%d/%m/%y")
            @shift.check_in_time = Time.now.strftime("%H:%M:%S")
            @shift.check_in_weekday = get_day
            if @shift.save
                flash[:notice] = "Du er nu scannet ind!"
                redirect_to root_path
            else
                render 'new'
            end
        end


        if params[:"ud"] == 'Tjek ud' && @worker.shifts.last.check_in_date != nil && @worker.shifts.last.check_out_date == nil
            
            @shift = @worker.shifts.last
            @shift.check_out_full_date = Time.now.strftime("%d/%m/%y")
            @shift.check_out_date = Time.now.strftime("%d/%m/%y")
            @shift.check_out_time = Time.now.strftime("%H:%M:%S")
            @shift.check_out_weekday = get_day
            if @shift.save
                flash[:alert] = "Du er nu scannet ud!"
                redirect_to root_path
            else
                render 'new'
            end
        
        elsif params[:"ud"] == 'Tjek ud' && @worker.shifts.last.check_in_date != nil  && @worker.shifts.last.check_out_date != nil
            flash[:alert] = "Du er ikke scannet ind, scan venligst ind før du scanner ud."
            redirect_to root_path
        end
        
    end


    private

    def shift_params
        params.require(:shift).permit(:worker_id)
    end

    def get_day
        case Time.now.wday
        when 1
            return "Mandag"
        when 2
            return "Tirsdag"
        when 3
            return "Onsdag"
        when 4
            return "Torsdag"
        when 5
            return "Fredag"
        when 6
            return "Lørdag"
        when 7
            return "Søndag"
        end
    end


end
