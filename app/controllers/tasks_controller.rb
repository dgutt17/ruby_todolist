class TasksController < ApplicationController
    def index
        @incomplete_tasks = Task.where(complete: false)
        @complete_tasks = Task.where(complete: true)
    end

    def show
        @task = Task.find(params[:id])
    end

    def new 
        @task = Task.new
    end

    def create
        @task = Task.new(allowed_params)
        respond_to do |format|
            if @task.save
                format.js
                format.html{redirect_to @band}
                format.json{render :show, status: :created, location: @task}
            else
                format.html {render :new}
                format.json {render json: @task.errors, status: :unprocessable_entity}
            end
        end
    end
    def destroy 
        @task = Task.find(params[:id])
        @task.destroy
        respond_to do |format|
            format.js
            format.html {redirect_to tasks_url}
            format.json {head :no_content}
        end
    end

    def edit
        @task = Task.find(params[:id])
    end

    def update
        @task = Task.find(params[:id])
        complete = @task.complete == false ? true: false
        @task.update_attributes(:complete => complete)
        respond_to do |format| 
            format.js
            format.html {redirect_to tasks_url}
            format.json {head :no_content}
        end
        redirect_to tasks_path
    end
    
    def allowed_params
        params.require(:task).permit(:name, :complete)
    end



end
