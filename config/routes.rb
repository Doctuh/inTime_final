Rails.application.routes.draw do

  root to: 'root#home'

  get 'admin/workers/all', to: 'admin#workers_index'
  get 'admin/workers/new', to: 'admin#workers_new'
  post 'admin/workers/new', to: 'admin#workers_create'

  delete 'admin/worker/delete', to: 'admin#worker_delete'
  get 'admin/shifts', to: 'admin#shifts_index'
  get 'admin/shifts/search', to: 'admin#shifts_search'
  get 'admin/shifts/show', to: 'admin#shifts_show'

  post 'shifts/new', to: 'shifts#create'


end
