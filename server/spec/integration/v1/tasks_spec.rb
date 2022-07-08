require 'swagger_helper'

describe 'toDo API tasks' do
  let!(:user) { create(:user, :to_logg) }
  let(:list) { user.lists[0] }
  let(:token) { "Bearer #{JwtServices::Encoder.call(id: user.id)}" }
  let(:task) { create(:task, list_id: list.id) }
  let!(:another_user) { create(:user) }
  let(:another_task) { create(:task, user_id: another_user.id, list_id: another_user.lists[0].id) }

  path '/v1/tasks' do

    post 'create task' do
      tags 'tasks'
      consumes 'application/json'
      produces 'application/json'
      security [JWT: []]
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string, example: 'task 1' },
          description: { type: :string, example: Faker::Lorem.paragraph },
          list_id: { type: :integer, example: Faker::Number.number(digits: 1) }
        },
        required: ['name', 'description', 'list_id']
      }

      response '201', 'return the id of task created' do
        let(:Authorization) { token }
        let(:params) { attributes_for(:task, list_id: list.id) }
        schema type: :object,
          properties: {
            id: { type: :integer, example: Faker::Number.number(digits: 2) }
          }
        run_test!
      end

      response '422', 'invalid parameters' do
        let(:params) { attributes_for(:task, :w_task) }
        let(:Authorization) { token }
        schema type: :object,
          properties: {
            errors: { type: :array, example: [
              "List must exist",
              "Name can't be blank",
              "List can't be blank",
              "Name the name has specials characters"
          ] }
          }
        run_test!
      end
    end
  end

  path '/v1/tasks/{id}' do

    get 'show task' do
      tags 'tasks'
      produces 'application/json'
      security [JWT: []]
      parameter name: :id, in: :path, type: :string

      response '200', 'task returned' do
        let(:id) { task.id }
        let(:Authorization) { token }
        schema type: :object,
          properties: {
            task: {
              type: :object,
              properties: {
                id: { type: :integer, example: 1 },
                name: { type: :string, example: "task 1" },
                description: { type: :string, exmaple: "abc" },
                list_id: { type: :integer, example: 5},
                created_at: { type: :string, example: "2022-06-23T20:40:28.305Z" },
                updated_at: { type: :string, example: "2022-06-23T20:40:28.305Z" }
              }
            }
          }
        run_test!
      end

      response '401', 'task not found or doesn`t belong to user logged' do
        let(:id) { another_task.id }
        let(:Authorization) { token }
        schema type: :object,
          properties: {
            errors: { type: :string, example: "Couldn't find task with 'id'=123" }
          }
        run_test!
      end
    end

    patch 'update task' do
      tags 'tasks'
      consumes 'application/json'
      produces 'application/json'
      security [JWT: []]
      parameter name: :id, in: :path, type: :string
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string, example: 'task 1' },
          description: { type: :string, example: Faker::Lorem.paragraph },
          list_id: { type: :integer, example: Faker::Number.number(digits: 1) }
        },
        required: ['name', 'description', 'list_id']
      }

      response '204', 'task updated - without response returned' do
        let(:id) { task.id }
        let(:params) { attributes_for(:task, list_id: list.id) }
        let(:Authorization) { token }
        run_test!
      end

      response '401', 'task not found' do
        let(:id) { 123 }
        let(:params) { attributes_for(:task, list_id: list.id) }
        let(:Authorization) { token }
        schema type: :object,
          properties: {
            errors: { type: :string, example: "Couldn't find task with 'id'= 123" }
          }
        run_test!
      end

      response '422', 'invalid parameters' do
        let(:id) { task.id }
        let(:params) { attributes_for(:task, :w_task) }
        let(:Authorization) { token }
        schema type: :object,
          properties: {
            errors: { type: :array, example: [
              "List must exist",
              "Name can't be blank",
              "List can't be blank",
              "Name the name has specials characters"
          ] }
          }
        run_test!
      end
    end

    put 'update task' do
      tags 'tasks'
      consumes 'application/json'
      produces 'application/json'
      security [JWT: []]
      parameter name: :id, in: :path, type: :string
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string, example: 'task 1' },
          description: { type: :string, example: Faker::Lorem.paragraph },
          list_id: { type: :integer, example: Faker::Number.number(digits: 1) }
        },
        required: ['name', 'description', 'list_id']
      }

      response '204', 'task updated - without response returned' do
        let(:id) { task.id }
        let(:params) { attributes_for(:task, list_id: list.id) }
        let(:Authorization) { token }
        run_test!
      end

      response '401', 'task not found' do
        let(:id) { 123 }
        let(:params) { attributes_for(:task, list_id: list.id) }
        let(:Authorization) { token }
        schema type: :object,
          properties: {
            errors: { type: :string, example: "Couldn't find task with 'id'= 123" }
          }
        run_test!
      end

      response '422', 'invalid parameters' do
        let(:id) { task.id }
        let(:params) { attributes_for(:task, :w_task) }
        let(:Authorization) { token }
        schema type: :object,
          properties: {
            errors: { type: :array, example: [
              "List must exist",
              "Name can't be blank",
              "List can't be blank",
              "Name the name has specials characters"
          ] }
          }
        run_test!
      end
    end

    delete 'delete task' do
      tags 'tasks'
      produces 'application/json'
      security [JWT: []]
      parameter name: :id, in: :path, type: :string

      response '204', 'task deleted - without response returned' do
        let(:id) { task.id }
        let(:params) { attributes_for(:task, list_id: list.id) }
        let(:Authorization) { token }
        run_test!
      end

      response '401', 'task not found' do
        let(:id) { 123 }
        let(:Authorization) { token }
        schema type: :object,
          properties: {
            errors: { type: :string, example: "Couldn't find task with 'id'=123" }
          }
        run_test!
      end

    end
  end

end
