require 'rails_helper'

describe 'FieldPicker' do
  let(:rails_tutorial) { create(:ruby_on_rails_tutorial) }
  let(:params) { { fields: 'id,title,subtitle' } }
  let(:presenter) { BookPresenter.new(rails_tutorial, params) }
  let(:field_picker) { FieldPicker.new(presenter) }
  # We don't want our tests to rely too much on the actual implementation of
  # the book presenter. Instead, we stub the method 'build_attributes'
  # on BookPresenter to always return the same list of attributes for
  # the tests in this file
  before do
    allow(BookPresenter).to(
      receive(:build_attributes).and_return(['id', 'title', 'author_id'])
    )
  end

  describe '#pick' do
    context 'with the "fields" parameter containing "id,title,subtitle"' do
      it 'updates the presenter "data" with the book "id" and "title"' do
        expect(field_picker.pick.data).to eq(
          'id' => rails_tutorial.id,
          'title' => rails_tutorial.title
        )
      end
    end

    context 'with the "fields" parameter containing "id,title,subtitle"' do
      before { presenter.class.send(:define_method, :title) { 'Overwritten' } }
      it 'updates the presenter "data" with the book "id" and "title"' do
        expect(field_picker.pick.data).to eq(
          'id' => rails_tutorial.id,
          'title' => 'Overwritten'
        )
      end
    end
  end
end
