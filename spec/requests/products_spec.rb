require 'rails_helper'

RSpec.describe "Products", type: :request do
  
  it 'access to products index' do
    get '/products'

    expect(response).to render_template(:index)
  end

  it 'get almost one product' do
    @products = Product.all

    expect(@products.length).to_not equal(0)
  end
end
