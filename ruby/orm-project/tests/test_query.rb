require './settings'

RSpec.describe QuerySet do
  # fields: full_name, age, profile
  describe '#order_by' do
    User.create_table
    Profile.create_table

    it 'orders_by_given_field' do
      User.objects.create(full_name: 'ivo', age: 22, profile: Profile.objects.create(avatar: 'snimka.png'))
      User.objects.create(full_name: 'ivo', age: 22, profile: Profile.objects.create(avatar: 'snimka.png'))
      qs = User.objects.order_by('pk')
      expect(qs.first.fields['pk'].to_s).to be >= qs.last.fields['pk'].to_s
    end
    it 'orders_by_given_field_desc' do
      User.objects.create(full_name: 'ivo', age: 22, profile: Profile.objects.create(avatar: 'snimka.png'))
      User.objects.create(full_name: 'ivo', age: 22, profile: Profile.objects.create(avatar: 'snimka.png'))
      qs = User.objects.order_by('pk', desc=true)
      expect(qs.first.fields['pk'].to_s).to be <= qs.last.fields['pk'].to_s
    end
  end

  describe '#count' do
    it 'returns_count_of_given_field' do
      users_count = User.objects.count
      User.objects.create(full_name: 'ivo', age: 22, profile: Profile.objects.create(avatar: 'snimka.png'))
      User.objects.create(full_name: 'ivo', age: 22, profile: Profile.objects.create(avatar: 'snimka.png'))
      expect(User.objects.count.class).to eq Fixnum
      expect(User.objects.count).to eq (users_count + 2)
    end
  end

  describe '#create' do
    it 'creates_and_saves_new_istance' do
      users_count = User.objects.count
      User.objects.create(full_name: 'ivo', age: 22, profile: Profile.objects.create(avatar: 'snimka.png'))
      expect(User.objects.count).to eq(users_count + 1)
    end
  end

  describe '#filter' do
    it 'filters_by_kwargs' do
      user = User.objects.create(full_name: 'ivo', age: 22, profile: Profile.objects.create(avatar: 'snimka.png'))
      User.objects.create(full_name: 'ivo', age: 22, profile: Profile.objects.create(avatar: 'snimka.png'))
      User.objects.create(full_name: 'ivo', age: 22, profile: Profile.objects.create(avatar: 'snimka.png'))
      expect(User.objects.filter(pk: user.fields['pk']).count).to eq 1
    end

    it 'allows_chaining' do
      user = User.objects.create(full_name: 'ivo1', age: 22, profile: Profile.objects.create(avatar: 'snimka.png'))
      User.objects.create(full_name: 'ivo1', age: 22, profile: Profile.objects.create(avatar: 'snimka.png'))
      User.objects.create(full_name: 'ivo1', age: 22, profile: Profile.objects.create(avatar: 'snimka.png'))
      users = User.objects.filter(full_name: 'ivo1')
      expect(users.count).to eq 3
      expect(users.filter(pk: user.fields['pk']).count).to eq 1
    end
  end

  describe '#limit' do
    it 'properly_limitate query' do
      expect(User.objects.count).to be >= 2
      expect(User.objects.limit(1).all.length).to eq 1
    end
  end

  describe '#get' do
    it 'returns_model_instance' do
      user = User.objects.create(full_name: 'ivo1', age: 22, profile: Profile.objects.create(avatar: 'snimka.png'))
      expect(User.objects.get(pk: user.fields['pk']).class).to eq User
    end

    it 'returns_nil_if_doesnt_exists' do
      expect(User.objects.get(pk: -1)).to eq nil
    end
  end

  describe '#first' do
    it 'returns_user_instance' do
      expect(User.objects.first.class).to eq User
    end
  end

  describe '#last' do
    it 'returns_user_instance' do
      expect(User.objects.last.class).to eq User
    end
  end
end
