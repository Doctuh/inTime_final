class AdminController < ApplicationController

    before_action :authenticate_user!

    def shifts_index
        @search = ShiftSearch.new(params[:search])
        @worker = Worker.all
        @shifts = Shift.all
       end

    def shifts_search
        @search = ShiftSearch.new(params[:search])
        @shifts = @search.scope
    end

    def shifts_show
        @worker = Worker.find(params[:format])
        @shifts = Shift.all
    end

    def workers_index
        @workers = Worker.all
    end

    def workers_new
        @worker = Worker.new
    end

    def worker_delete
        @worker = Worker.find(params[:format])

        if @worker.shifts.each do |ws|
            ws.delete
        end

        if @worker.delete
            @worker.shifts.each do |ws|
                ws.delete
            end
            flash[:notice] = "Følgende medarbejder: #{@worker.name} er blevet fjernet!"
            redirect_to admin_workers_all_path
        end
    end
    end

    def workers_create
        @worker = Worker.new(worker_params)
        if @worker.save
            flash[:notice] = "Medarbejder oprettet!"
            redirect_to admin_workers_all_path
        else
            render 'workers_new'
        end
    end

    private

    def worker_params
        params.require(:worker).permit(:name)
    end



end
