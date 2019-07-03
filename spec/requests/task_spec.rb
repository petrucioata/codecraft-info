# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Task', type: :request do
  let!(:task) { create(:task) }

  describe 'lists all tasks' do
    subject(:list_tasks) { get tasks_path }

    # before { create(:task) }

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
    subject(:create_task) do
      post tasks_path, params: { task: params }
    end

    let(:new_task) { get new_task_path }
    let(:params) do
      {
        "name": Faker::Lorem.sentence,
        "author": Faker::FunnyName.name,
        "description": Faker::Quote.yoda,
        "edition": task.edition_id
      }
    end

    context 'when the required params are provided' do
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
  end
end
