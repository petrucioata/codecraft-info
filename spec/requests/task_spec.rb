# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tasks', type: :request do
  let!(:task) { create(:task, :for_edition) }
  let(:other_task) { create(:task) }
  let!(:user) { create(:user, password: 'pass123') }
  let(:file) { fixture_file_upload('test_case.txt', 'text') }

  describe 'lists all tasks' do
    subject(:list_tasks) { get tasks_path }

    it 'returns a successful response' do
      list_tasks
      response.should be_successful
    end

    it 'renders the index template' do
      list_tasks
      response.should render_template(:index)
    end
  end

  describe 'create a new Task' do
    subject(:create_task) { post tasks_path, params: { task: params } }

    before { login(user.email, user.password) }

    let(:params) do
      {
        "name": Faker::Lorem.sentence,
        "author": Faker::FunnyName.name,
        "description": Faker::Quote.yoda,
        "edition": task.edition_id,
        "test_cases": [Rack::Test::UploadedFile.new(file)]
      }
    end

    context 'when the required params are provided' do
      subject(:new_task) { get new_task_path }

      it 'renders new Task view' do
        new_task
        response.should render_template(:new)
      end

      it { expect { create_task }.to change(Task, :count).by(1) }
      it { expect { create_task }.to change(ActiveStorage::Attachment, :count).by(1) }

      it "redirect to the Task's page" do
        create_task.should redirect_to redirect_to(assigns(:task))
        follow_redirect!

        response.should render_template(:show)
        expect(response.body).to include('Task was successfully created')
      end
    end

    context 'when the name is not unique' do
      before { params[:name] = task.name }

      it 'render new Task view and returns the corresponding error message' do
        create_task
        response.should render_template(:new)
        expect(response.body).to include('Name has already been taken')
      end
    end

    context 'when the required params are missing' do
      let(:params) do
        {
          "author": Faker::FunnyName.name,
          "description": Faker::Quote.yoda
        }
      end

      it 'render new Task view and returns the corresponding error message' do
        create_task
        response.should render_template(:new)
        expect(response.body).to include('Name can&#39;t be blank')
      end
    end
  end

  describe 'updates a Task' do
    subject(:update_task) { patch task_path(task), params: { task: params } }

    before { login(user.email, user.password) }

    let(:params) do
      {
        "name": Faker::Lorem.sentence,
        "test_cases": [Rack::Test::UploadedFile.new(file)]
      }
    end

    context 'when the params are correct' do
      it 'updates the task' do
        update_task
        expect(task.reload.name).to eq params[:name]
      end

      it { expect { update_task }.to change(ActiveStorage::Attachment, :count).by(1) }

      it "redirects to Task's page" do
        update_task.should redirect_to(task_path(task))
        follow_redirect!

        expect(response.body).to include('Task was successfully updated')
      end
    end

    context 'when some parameters are wrong' do
      before { params[:name] = other_task.name }

      it 'renders edit Task view' do
        update_task
        response.should render_template(:edit)
      end

      it 'returns the corresponding error message' do
        update_task
        expect(response.body).to include('Name has already been taken')
      end
    end
  end

  describe 'deletes a Task' do
    subject(:delete_task) { delete task_path(task) }

    before { login(user.email, user.password) }

    context 'when the task is find' do
      it 'sets deleted to true' do
        delete_task
        expect(task.reload.deleted).to eq true
      end

      it 'redirects to tasks list' do
        delete_task.should redirect_to(tasks_path)
      end
    end
  end
end
