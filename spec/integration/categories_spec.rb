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

  path '/categories/{id}' do
    get 'Retrieves a category by ID' do
      tags 'Categories'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer

      response '200', 'category found' do
        let(:category) { Category.create(name: 'Test Category', status: 'active') }
        let(:id) { category.id }

        schema type: :object,
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

        run_test!
      end

      response '404', 'category not found' do
        let(:id) { -1 }
        run_test!
      end
    end
  end
end
