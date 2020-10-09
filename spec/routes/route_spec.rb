# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Routing', type: :routing do
  let(:id) { 1 }

  describe 'routes for dashboard' do
    it { should route(:get, '/').to(controller: :dashboard, action: :index) }
  end

  describe 'routes for editions' do
    it { should route(:get, '/editions').to(controller: :editions, action: :index) }
    it { should route(:post, '/editions').to(controller: :editions, action: :create) }
    it { should route(:get, '/editions/new').to(controller: :editions, action: :new) }
    it { should route(:get, "/editions/#{id}/edit").to(controller: :editions, action: :edit, id: id) }
    it { should route(:get, "/editions/#{id}").to(controller: :editions, action: :show, id: id) }
    it { should route(:patch, "/editions/#{id}").to(controller: :editions, action: :update, id: id) }
    it { should route(:put, "/editions/#{id}").to(controller: :editions, action: :update, id: id) }
    it { should route(:delete, "/editions/#{id}").to(controller: :editions, action: :destroy, id: id) }
    it { should route(:get, "/editions/#{id}/import").to(controller: :editions, action: :new_import, id: id) }
    it { should route(:post, "/editions/#{id}").to(controller: :editions, action: :import, id: id) }
  end

  describe 'routes for tasks' do
    it { should route(:get, '/tasks').to(controller: :tasks, action: :index) }
    it { should route(:post, '/tasks').to(controller: :tasks, action: :create) }
    it { should route(:get, '/tasks/new').to(controller: :tasks, action: :new) }
    it { should route(:get, "/tasks/#{id}/edit").to(controller: :tasks, action: :edit, id: id) }
    it { should route(:get, "/tasks/#{id}").to(controller: :tasks, action: :show, id: id) }
    it { should route(:patch, "/tasks/#{id}").to(controller: :tasks, action: :update, id: id) }
    it { should route(:put, "/tasks/#{id}").to(controller: :tasks, action: :update, id: id) }
    it { should route(:delete, "/tasks/#{id}").to(controller: :tasks, action: :destroy, id: id) }
  end

  describe 'routes for participants' do
    it { should route(:get, '/participants').to(controller: :participants, action: :index) }
    it { should route(:post, '/participants').to(controller: :participants, action: :create) }
    it { should route(:get, '/participants/new').to(controller: :participants, action: :new) }
    it { should route(:get, "/participants/#{id}/edit").to(controller: :participants, action: :edit, id: id) }
    it { should route(:get, "/participants/#{id}").to(controller: :participants, action: :show, id: id) }
    it { should route(:patch, "/participants/#{id}").to(controller: :participants, action: :update, id: id) }
    it { should route(:put, "/participants/#{id}").to(controller: :participants, action: :update, id: id) }
    it { should route(:delete, "/participants/#{id}").to(controller: :participants, action: :destroy, id: id) }
  end

  describe 'routes for sessions' do
    it { should route(:get, '/admin').to(controller: :sessions, action: :new) }
    it { should route(:post, '/admin').to(controller: :sessions, action: :create) }
    it { should route(:delete, '/logout').to(controller: :sessions, action: :destroy) }
  end
end
