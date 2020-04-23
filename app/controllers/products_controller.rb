class ProductsController < ApplicationController

def new; end

def create; end

def show; end

def failure
  raise ActiveRecord::RecordNotFound
end

def some_worker_job
  SomeWorker.perform_async
  redirect_back(fallback_location: root_path)
end
   
private
  def product_params
    params.require(:product).permit(:name, :description)
  end
end
