# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Task', type: :request do
  let!(:task) { create(:task) }

  describe 'lists all tasks' do
    subject(:list_tasks) { get tasks_path }

    it 'returns a successful response' do
      list_tasks
      expect(response).to be_successful
    end

    it 'renders the index template' do
      list_tasks
      expect(response).to render_template(:index)
    end
  end

  describe 'create a new Task' do
    subject(:create_task) { post tasks_path, params: { task: params } }

    let(:params) do
      {
        "name": Faker::Lorem.sentence,
        "author": Faker::FunnyName.name,
        "description": Faker::Quote.yoda,
        "edition": task.edition_id
      }
    end

    context 'when the required params are provided' do
      subject(:new_task) { get new_task_path }

      it 'renders new Task view' do
        new_task
        expect(response).to render_template(:new)
      end

      it { expect { create_task }.to change(Task, :count).by(1) }

      it "redirect to the Task's page" do
        create_task
        redirect_to(assigns(:task))
        follow_redirect!

        expect(response).to render_template(:show)
        expect(response.body).to include('Task was successfully created')
      end
    end

    context 'when the name is not unique' do
      before { params[:name] = task.name }

      it 'render new Task view and returns the corresponding error message' do
        create_task
        expect(response).to render_template(:new)
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
        expect(response).to render_template(:new)
        expect(response.body).to include('Name can&#39;t be blank')
      end
    end
  end
end
