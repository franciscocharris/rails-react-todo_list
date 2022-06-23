require 'swagger_helper'

describe 'toDo API lists' do
  let!(:user) { create(:user, :to_logg) }
  let(:token) { "Bearer #{JwtServices::Encoder.call(id: user.id)}" }

  path '/v1/lists' do
    get 'index' do
      tags 'lists'
      consumes 'application/json'
      produces 'application/json'
      security [JWT: []]

      response '200', 'return user`s lists' do
        schema type: :object,
          properties: {
            data: {
              type: :array,
              items: {
                type: :object,
                properties: {
                  id: { type: :integer, example: 1 },
                  type: { type: :string, example: 'lists' },
                  attributes: {
                    type: :object,
                    properties: {
                      name: { type: :string, example: "Doing" },
                      n_position: {type: :integer, example: 2}
                    }
                  }
                }
              }
            }
          }
        let(:Authorization) { token }
        run_test!
      end

      response '1. 403', 'header was no sent' do
        schema type: :object,
          properties: {
            errors: { type: :string, example: 'authentication header wasn`t sent' }
          }
        run_test!
      end

      response '2. 403', 'header has incorrect format' do
        let(:token) { token.gsub('Bearer') }
        schema type: :object,
          properties: {
            errors: { type: :string, example: 'authentication header has invalid format' }
          }
        run_test!
      end

      response '204', 'the user has no lists to show' do
        let(:Authorization) { token }
        schema type: :object,
          properties: {
            errors: { type: :string, example: 'there`s no lists to show' }
          }
        run_test!
      end

      response '400', 'incorrect request was sent' do
        let(:Authorization) { token }
        schema type: :object,
          properties: {
            errors: {
              type: :string,
              example: "859: unexpected token at '{\n  \"first_name\": \"$_ft\",\n  \"last_name\": \" crfrfr\",\n  \"email\": \"user@gmail.com\",\n  \"password\": ''\n}'"
            }
          }
        run_test!
      end

    end
    post 'create list' do
      tags 'lists'
      consumes 'application/json'
      produces 'application/json'
      security [JWT: []]
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string, example: 'backlog week 1' },
          n_position: { type: :integer, example: 4 }
        },
        required: ['name', 'n_position']
      }

      response '201', 'return the id of list created' do
        let(:Authorization) { token }
        let(:params) { attributes_for(:list, n_position: user.lists.count+1, user_id: user.id) }
        schema type: :object,
          properties: {
            id: { type: :integer, example: Faker::Number.number(digits: 2) }
          }
        run_test!
      end

      response '422', 'invalid parameters' do
        let(:params) { attributes_for(:list, :w_list, user_id: user.id) }
        schema type: :object,
          properties: {
            errors: { type: :array, example: [
              "N position has already been taken"
            ] }
          }
        run_test!
      end

      response '400', 'incorrect request was sent' do
        let(:params) { attributes_for(:user, :w_user) }
        schema type: :object,
          properties: {
            errors: {
              type: :string,
              example: "859: unexpected token at '{\n  \"first_name\": \"$_ft\",\n  \"last_name\": \" crfrfr\",\n  \"email\": \"user@gmail.com\",\n  \"password\": ''\n}'"
            }
          }
        run_test!
      end

    end
  end

  path '/v1/lists/{id}' do

    patch 'update list' do
      tags 'lists'
      consumes 'application/json'
      produces 'application/json'
      security [JWT: []]
      parameter name: :id, in: :path, type: :string
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string, example: 'backlog week 1' }
        },
        required: ['name']
      }

      response '204', 'list updated - without response returned' do
        let(:id) { create(:list, n_position: user.lists.count+1, user_id: user.id).id }
        let(:Authorization) { token }
        run_test!
      end

      response '401', 'list not found' do
        let(:id) { 123 }
        let(:Authorization) { token }
        schema type: :object,
          properties: {
            errors: { type: :string, example: "Couldn't find List with 'id'= #{123}" }
          }
        run_test!
      end

      response '422', 'invalid parameters' do
        let(:id) { create(:list, n_position: user.lists.count+1, user_id: user.id).id }
        let(:Authorization) { token }
        schema type: :object,
          properties: {
            errors: { type: :array, example: [
              "N position has already been taken"
            ] }
          }
        run_test!
      end
    end

    put 'update list' do
      tags 'lists'
      consumes 'application/json'
      produces 'application/json'
      security [JWT: []]
      parameter name: :id, in: :path, type: :string
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string, example: 'backlog week 1' }
        },
        required: ['name']
      }

      response '204', 'list updated - without response returned' do
        let(:id) { create(:list, n_position: user.lists.count+1, user_id: user.id).id }
        let(:Authorization) { token }
        run_test!
      end

      response '401', 'list not found' do
        let(:id) { 123 }
        let(:Authorization) { token }
        schema type: :object,
          properties: {
            errors: { type: :string, example: "Couldn't find List with 'id'= #{123}" }
          }
        run_test!
      end

      response '422', 'invalid parameters' do
        let(:id) { create(:list, n_position: user.lists.count+1, user_id: user.id).id }
        let(:Authorization) { token }
        schema type: :object,
          properties: {
            errors: { type: :array, example: [
              "N position has already been taken"
            ] }
          }
        run_test!
      end
    end


    delete 'delete list' do
      tags 'lists'
      produces 'application/json'
      security [JWT: []]
      parameter name: :id, in: :path, type: :string

      response '204', 'list deleted - without response returned' do
        let(:id) { create(:list, n_position: user.lists.count+1, user_id: user.id).id }
        let(:Authorization) { token }
        run_test!
      end

      response '401', 'list not found' do
        let(:id) { 123 }
        let(:Authorization) { token }
        schema type: :object,
          properties: {
            errors: { type: :string, example: "Couldn't find List with 'id'= #{123}" }
          }
        run_test!
      end

      response '422', 'invalid parameters' do
        let(:id) { create(:list, n_position: user.lists.count+1, user_id: user.id).id }
        let(:Authorization) { token }
        run_test!
      end
    end
  end

  path '/v1/lists/{id}/change_position' do
    post 'update the position of list' do
      tags 'lists'
      produces 'application/json'
      security [JWT: []]
      parameter name: :id, in: :path, type: :string
      parameter name: :n_position1, in: :body, schema: {
        type: :object,
        properties: {
          n_position: { type: :integer, example: 5 }
        },
        required: ['n_position']
      }

      response '204', 'list updated - without response returned' do
        let(:id) { create(:list, n_position: user.lists.count+1, user_id: user.id).id }
        let(:Authorization) { token }
        let(:n_position1) { 5 }
        run_test!
      end

      response '401', 'list not found' do
        let(:id) { 123 }
        let(:Authorization) { token }
        schema type: :object,
          properties: {
            errors: { type: :string, example: "Couldn't find List with 'id'= #{123}" }
          }
        run_test!
      end

      response '422', 'invalid parameters' do
        let(:id) { create(:list, n_position: user.lists.count+1, user_id: user.id).id }
        let(:Authorization) { token }
        schema type: :object,
          properties: {
            errors: { type: :array, example: [
              "n_position must be sent"
            ] }
          }
        run_test!
      end
    end
  end
end
