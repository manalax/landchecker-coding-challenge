# frozen_string_literal: true

require 'rails_helper'
require '../submission/app/controllers/api/v1/lgas_controller'

RSpec.describe Api::V1::LgasController, type: :controller do
  let(:valid_lga) { create(:lga) }

  # TODO: specs for the rest of the controller's actions

  describe 'GET index' do
    it 'has a 200 status code' do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /show' do
    describe 'when given a valid id' do
      it 'renders a successful response' do
        lga = Lga.create! { valid_lga }
        get :show, params: { id: valid_lga.id }
        expect(response.status).to eq(200)
      end
    end

    describe 'when given a non-existant id' do
      it 'returns 404' do
        get :show, params: { id: '10000' }
        expect(response.status).to eq(404)
      end
    end

    describe 'when given an improper id, such as a string' do
      it 'renders an error' do
        get :show, params: { id: 'blah' }
        expect(response.status).to eq(400)
      end
    end
  end
end


