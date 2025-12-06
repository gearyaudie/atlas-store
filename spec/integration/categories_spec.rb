require 'swagger_helper'

RSpec.describe 'Categories API', type: :request do
  path '/categories' do
    get 'Retrieves all categories' do
      tags 'Categories'
      produces 'application/json'

      response '200', 'categories found' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   name: { type: :string },
                   status: { type: :string },
                   created_by: { type: :string, nullable: true },
                   updated_by: { type: :string, nullable: true },
                   created_at: { type: :string, format: 'date-time' },
                   updated_at: { type: :string, format: 'date-time' }
                 },
                 required: ['id', 'name', 'status', 'created_at', 'updated_at']
               }

        run_test!
      end
    end
  end

  path '/categories/{id}/with-menu' do
    get 'Retrieves a category and all its menus' do
      tags 'Categories'
      produces 'application/json'

      parameter name: :id, in: :path, type: :integer, description: 'Category ID'

      response '200', 'category with menus found' do
        schema type: :object,
               properties: {
                 category: {
                   type: :object,
                   properties: {
                     id: { type: :integer },
                     name: { type: :string },
                     status: { type: :string },
                     created_by: { type: :string, nullable: true },
                     updated_by: { type: :string, nullable: true },
                     created_at: { type: :string, format: 'date-time' },
                     updated_at: { type: :string, format: 'date-time' }
                   },
                   required: ['id', 'name', 'status', 'created_at', 'updated_at']
                 },
                 menus: {
                   type: :object,
                   properties: {
                     data: {
                       type: :array,
                       items: {
                         type: :object,
                         properties: {
                           id: { type: :integer },
                           category_id: { type: :integer },
                           name: { type: :string },
                           description: { type: :string, nullable: true },
                           price: { type: :number },
                           status: { type: :string },
                           created_by: { type: :string, nullable: true },
                           updated_by: { type: :string, nullable: true },
                           created_at: { type: :string, format: 'date-time' },
                           updated_at: { type: :string, format: 'date-time' }
                         },
                         required: ['id', 'category_id', 'name', 'price', 'status']
                       }
                     },
                     count: { type: :integer }
                   },
                   required: ['data', 'count']
                 }
               },
               required: ['category', 'menus']

        run_test!
      end

      response '404', 'category not found' do
        run_test!
      end
    end
end
