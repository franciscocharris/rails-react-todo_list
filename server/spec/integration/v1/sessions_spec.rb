require 'swagger_helper'

describe 'toDo API sessions' do
  let!(:user) { create(:user, :to_logg) }

  path '/v1/signup' do
    post 'signup user' do
      tags 'sessions'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          first_name: { type: :string, example: Faker::Name.first_name },
          last_name: { type: :syring, example: Faker::Name.last_name },
          email: { type: :string, example: 'user@gmail.com' },
          password: { type: :string, example: '12345678' }
        },
        required: ['first_name', 'last_name', 'email', 'password']
      }

      response '200', 'return a JWT' do
        let(:params) { attributes_for(:user) }
        schema type: :object,
          properties: {
            token: { type: :string, example: JwtServices::Encoder.call(id: 2) }
          }
        run_test!
      end

      response '422', 'invalid parameters' do
        let(:params) { attributes_for(:user, :to_logg) }
        schema type: :object,
          properties: {
            errors: { type: :array, example: [
              "Password can't be blank",
              "First name can't be blank",
              "Last name can't be blank",
              "Email can't be blank",
              "Email is invalid",
              "Password is too short (minimum is 6 characters)"
            ] }
          }
        run_test!
      end
    end
  end

  path '/v1/login' do
    post 'login user' do
      tags 'sessions'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :login, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string, example: 'user@gmail.com' },
          password: { type: :string, example: '12345678' }
        },
        required: ['email', 'password']
      }

      response '200', 'return a JWT' do
        let(:login) { { email: user.email, password: '12345678' } }
        schema type: :object,
          properties: {
            token: { type: :string, example: JwtServices::Encoder.call(id: 1) }
          }
        run_test!
      end

      response '401', 'wrong credentials' do
        let(:login) { { email: 'wrong_e@gmail.com', password: 'bar' } }
        schema type: :object,
          properties: {
            errors: { type: :string, example: 'wrong credentials' }
          }
        run_test!
      end
    end
  end
end
