class ProductsController < ApplicationController

  def new; end

  def create; end

  def show; end

  def failure
    raise ActiveRecord::RecordNotFound
  end

  def some_worker_job
    SomeWorker.perform_async
    render plain: 'Worker scheduled'
  end
end
