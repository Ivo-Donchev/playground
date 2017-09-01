require './settings'

RSpec.describe User do
  # fields: full_name, age, profile
  describe '#default_fields' do
    it 'returns_dict_from_pk_field' do
      expect(User.default_fields.keys).to eq ['pk']
    end
    it 'returns_autofield_value_for_pk_field' do
      expect(User.default_fields['pk'].class).to eq(AutoField)
    end
  end
  describe '#all_fields' do
    it 'returns_custom_fields_merged_with_default' do
      expect(User.all_fields.keys).to eq ['pk', 'full_name', 'age', 'profile']
    end
  end
  describe '#objects' do
    it 'returns_qs_instance' do
      expect(User.objects.class).to eq QuerySet
    end
  end
  describe '#create_table' do
    it 'creates_db_without_errors' do
      # TODO: implement this
    end
  end
  describe '#drop_table' do
    it 'drops_db_without_errors' do
      # TODO: implement this
    end
  end

  describe '#update' do
    it 'updates_instance' do
      # TODO: Implement this
    end
  end
end
