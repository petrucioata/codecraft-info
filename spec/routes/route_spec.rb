# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Routing', type: :routing do
  describe 'routes for dashboard' do
    it { should route(:get, '/').to(controller: :dashboard, action: :index) }
  end

  describe 'routes for editions' do
    it { should route(:get, '/editions').to(controller: :editions, action: :index) }
    it { should route(:post, '/editions').to(controller: :editions, action: :create) }
    it { should route(:get, '/editions/new').to(controller: :editions, action: :new) }
    it { should route(:get, '/editions/1/edit').to(controller: :editions, action: :edit, id: 1) }
    it { should route(:get, '/editions/1').to(controller: :editions, action: :show, id: 1) }
    it { should route(:patch, '/editions/1').to(controller: :editions, action: :update, id: 1) }
    it { should route(:put, '/editions/1').to(controller: :editions, action: :update, id: 1) }
    it { should route(:delete, '/editions/1').to(controller: :editions, action: :destroy, id: 1) }
    it { should route(:get, '/editions/1/import').to(controller: :editions, action: :new_import, id: 1) }
    it { should route(:post, '/editions/1').to(controller: :editions, action: :import, id: 1) }
  end

  describe 'routes for tasks' do
    it { should route(:get, '/tasks').to(controller: :tasks, action: :index) }
    it { should route(:post, '/tasks').to(controller: :tasks, action: :create) }
    it { should route(:get, '/tasks/new').to(controller: :tasks, action: :new) }
    it { should route(:get, '/tasks/1/edit').to(controller: :tasks, action: :edit, id: 1) }
    it { should route(:get, '/tasks/1').to(controller: :tasks, action: :show, id: 1) }
    it { should route(:patch, '/tasks/1').to(controller: :tasks, action: :update, id: 1) }
    it { should route(:put, '/tasks/1').to(controller: :tasks, action: :update, id: 1) }
    it { should route(:delete, '/tasks/1').to(controller: :tasks, action: :destroy, id: 1) }
  end

  describe 'routes for participants' do
    it { should route(:get, '/participants').to(controller: :participants, action: :index) }
    it { should route(:post, '/participants').to(controller: :participants, action: :create) }
    it { should route(:get, '/participants/new').to(controller: :participants, action: :new) }
    it { should route(:get, '/participants/1/edit').to(controller: :participants, action: :edit, id: 1) }
    it { should route(:get, '/participants/1').to(controller: :participants, action: :show, id: 1) }
    it { should route(:patch, '/participants/1').to(controller: :participants, action: :update, id: 1) }
    it { should route(:put, '/participants/1').to(controller: :participants, action: :update, id: 1) }
    it { should route(:delete, '/participants/1').to(controller: :participants, action: :destroy, id: 1) }
  end

  describe 'routes for sessions' do
    it { should route(:get, '/admin').to(controller: :sessions, action: :new) }
    it { should route(:post, '/admin').to(controller: :sessions, action: :create) }
    it { should route(:delete, '/logout').to(controller: :sessions, action: :destroy) }
  end
end
