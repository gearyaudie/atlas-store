# spec/integration/options_spec.rb
require 'swagger_helper'

RSpec.describe 'Options API', type: :request do
  path '/options' do
    get 'Retrieves all options' do
      tags 'Options'
      produces 'application/json'

      response '200', 'options found' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   name: { type: :string },
                   description: { type: :string, nullable: true },
                   price: { type: :number },
                   status: { type: :string },
                   menu_id: { type: :integer },
                   created_by: { type: :string, nullable: true },
                   updated_by: { type: :string, nullable: true },
                   created_at: { type: :string, format: 'date-time' },
                   updated_at: { type: :string, format: 'date-time' }
                 },
                 required: ['id', 'name', 'price', 'status', 'menu_id', 'created_at', 'updated_at']
               }

        run_test!
      end
    end
  end

  path '/options/{id}' do
    get 'Retrieves an option by ID' do
      tags 'Options'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer

      response '200', 'option found' do
        let(:menu) { Menu.create(name: 'Test Menu', price: 10.0, status: 'active', category_id: 1) }
        let(:option) { Option.create(name: 'Test Option', price: 5.0, status: 'active', menu_id: menu.id) }
        let(:id) { option.id }

        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 description: { type: :string, nullable: true },
                 price: { type: :number },
                 status: { type: :string },
                 menu_id: { type: :integer },
                 created_by: { type: :string, nullable: true },
                 updated_by: { type: :string, nullable: true },
                 created_at: { type: :string, format: 'date-time' },
                 updated_at: { type: :string, format: 'date-time' }
               },
               required: ['id', 'name', 'price', 'status', 'menu_id', 'created_at', 'updated_at']

        run_test!
      end

      response '404', 'option not found' do
        let(:id) { -1 }
        run_test!
      end
    end
  end

  path '/menus/{menu_id}/options' do
    get 'Retrieves options by menu ID' do
      tags 'Options'
      produces 'application/json'
      parameter name: :menu_id, in: :path, type: :integer

      response '200', 'options found for menu' do
        let(:category) { Category.create(name: 'Test Category', status: 'active') }
        let(:menu) { Menu.create(name: 'Test Menu', price: 10.0, status: 'active', category_id: category.id) }
        let!(:option) { Option.create(name: 'Test Option', price: 5.0, status: 'active', menu_id: menu.id) }
        let(:menu_id) { menu.id }

        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   name: { type: :string },
                   description: { type: :string, nullable: true },
                   price: { type: :number },
                   status: { type: :string },
                   menu_id: { type: :integer },
                   created_by: { type: :string, nullable: true },
                   updated_by: { type: :string, nullable: true },
                   created_at: { type: :string, format: 'date-time' },
                   updated_at: { type: :string, format: 'date-time' }
                 },
                 required: ['id', 'name', 'price', 'status', 'menu_id', 'created_at', 'updated_at']
               }

        run_test!
      end

      response '404', 'menu not found' do
        let(:menu_id) { -1 }
        run_test!
      end
    end
  end
end
