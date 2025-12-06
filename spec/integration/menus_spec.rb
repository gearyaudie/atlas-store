# spec/integration/menus_spec.rb
require 'swagger_helper'

RSpec.describe 'Menus API', type: :request do
  path '/menus' do
    get 'Retrieves all menus' do
      tags 'Menus'
      produces 'application/json'

      response '200', 'menus found' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   name: { type: :string },
                   description: { type: :string, nullable: true },
                   price: { type: :number },
                   status: { type: :string },
                   category_id: { type: :integer },
                   created_by: { type: :string, nullable: true },
                   updated_by: { type: :string, nullable: true },
                   created_at: { type: :string, format: 'date-time' },
                   updated_at: { type: :string, format: 'date-time' }
                 },
                 required: ['id', 'name', 'price', 'status', 'category_id', 'created_at', 'updated_at']
               }

        run_test!
      end
    end
  end

  path '/menus/{id}' do
    get 'Retrieves a menu by ID' do
      tags 'Menus'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer

      response '200', 'menu found' do
        let(:menu) { Menu.create(name: 'Test Menu', price: 10.0, status: 'active', category_id: 1) }
        let(:id) { menu.id }

        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 description: { type: :string, nullable: true },
                 price: { type: :number },
                 status: { type: :string },
                 category_id: { type: :integer },
                 created_by: { type: :string, nullable: true },
                 updated_by: { type: :string, nullable: true },
                 created_at: { type: :string, format: 'date-time' },
                 updated_at: { type: :string, format: 'date-time' }
               },
               required: ['id', 'name', 'price', 'status', 'category_id', 'created_at', 'updated_at']

        run_test!
      end

      response '404', 'menu not found' do
        let(:id) { -1 }
        run_test!
      end
    end
  end

  path '/categories/{category_id}/menus' do
    get 'Retrieves menus by category ID' do
      tags 'Menus'
      produces 'application/json'
      parameter name: :category_id, in: :path, type: :integer

      response '200', 'menus found for category' do
        let(:category) { Category.create(name: 'Test Category', status: 'active') }
        let!(:menu) { Menu.create(name: 'Test Menu', price: 10.0, status: 'active', category_id: category.id) }
        let(:category_id) { category.id }

        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   name: { type: :string },
                   description: { type: :string, nullable: true },
                   price: { type: :number },
                   status: { type: :string },
                   category_id: { type: :integer },
                   created_by: { type: :string, nullable: true },
                   updated_by: { type: :string, nullable: true },
                   created_at: { type: :string, format: 'date-time' },
                   updated_at: { type: :string, format: 'date-time' }
                 },
                 required: ['id', 'name', 'price', 'status', 'category_id', 'created_at', 'updated_at']
               }

        run_test!
      end

      response '404', 'category not found' do
        let(:category_id) { -1 }
        run_test!
      end
    end
  end

  path '/menus/{menu_id}/with-options' do
    get 'Retrieves a menu and all its options' do
      tags 'Menus'
      produces 'application/json'

      parameter name: :menu_id, in: :path, type: :integer, description: 'Menu ID'

      response '200', 'menu with options found' do
        let(:menu_record) { Menu.create(name: 'Test Menu', price: 10.0, status: 'active', category_id: 1) }
        let!(:option) { Option.create(name: 'Large', price: 2.5, status: 'active', menu_id: menu_record.id) }
        let(:menu_id) { menu_record.id }

        schema type: :object,
               properties: {
                 menu: {
                   type: :object,
                   properties: {
                     id: { type: :integer },
                     name: { type: :string },
                     description: { type: :string, nullable: true },
                     price: { type: :number },
                     status: { type: :string },
                     category_id: { type: :integer },
                     created_by: { type: :string, nullable: true },
                     updated_by: { type: :string, nullable: true },
                     created_at: { type: :string, format: 'date-time' },
                     updated_at: { type: :string, format: 'date-time' }
                   },
                   required: ['id', 'name', 'price', 'status', 'category_id', 'created_at', 'updated_at']
                 },
                 options: {
                   type: :object,
                   properties: {
                     data: {
                       type: :array,
                       items: {
                         type: :object,
                         properties: {
                           id: { type: :integer },
                           menu_id: { type: :integer },
                           name: { type: :string },
                           price: { type: :number },
                           status: { type: :string },
                           created_by: { type: :string, nullable: true },
                           updated_by: { type: :string, nullable: true },
                           created_at: { type: :string, format: 'date-time' },
                           updated_at: { type: :string, format: 'date-time' }
                         },
                         required: ['id', 'menu_id', 'name', 'price', 'status']
                       }
                     },
                     count: { type: :integer }
                   },
                   required: ['data', 'count']
                 }
               },
               required: ['menu', 'options']

        run_test!
      end

      response '404', 'menu not found' do
        let(:menu_id) { -1 }
        run_test!
      end
    end
  end
end
