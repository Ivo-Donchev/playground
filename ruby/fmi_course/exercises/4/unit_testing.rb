RSpec.describe 'Version' do
  def version(version_string)
    Version.new(version_string)
  end

  describe 'initializing' do
    it 'raises ArgumentError if wrong format is given' do
      expect { version('wrong_format') }.to raise_error ArgumentError
      expect { version('1.1.') }.to raise_error ArgumentError
      expect { version('.1.1') }.to raise_error ArgumentError
      expect { version('1..1') }.to raise_error ArgumentError
      expect { version('.') }.to raise_error ArgumentError
      expect { version('v1') }.to raise_error ArgumentError
    end

    it 'describes error if error is raised' do
      invalid_version_string = 'v1'
      expect { version(invalid_version_string) }.to raise_error(
        ArgumentError,
        "Invalid version string '#{invalid_version_string}'"
      )
    end

    it 'allows empty string and it is equal to 0' do
      expect(version('')).to eq version('0')
    end

    it 'allows creating object without arguments, eq to 0' do
      expect(Version.new).to eq version('0')
    end

    it 'can be initialized from another Version instance' do
      expect(version(Version.new('1.1'))).to eq version('1.1')
    end
  end

  describe 'comparisions' do
    it 'can compare version to version' do
      expect(version('3.1.1')).to eq version('3.1.1')
    end

    it 'correctly compares equal versions' do
      expect(version('3.0.1')).to eq version('3.0.1')
      expect(version('0.1.1')).to eq version('0.1.1')
      expect(version('2.1.2')).to eq version('2.1.2')
    end

    it 'assumes unspecified components are zeros' do
      expect(version('3.0.1')).to eq version('3.0.1.0')
      expect(version('3.0.1.0.0.0.0')).to eq version('3.0.1')
    end

    it 'compares unequalities properly' do
      expect(version('3.0.1')).to be <= version('3.0.1.0')
      expect(version('3.0.1')).to be >= version('3.0.1.0')
      expect(version('0.0.1')).to be <= version('3.0.0')
      expect(version('3.0.1')).to be <= version('3.0.2')
      expect(version('3.0.1')).to be >= version('2.0.2')
      expect(version('3.0.1')).to be >= version('')
    end
  end

  describe '#to_s' do
    it 'parses versions to string correctly' do
      expect(version('3.0.1').to_s).to eq '3.0.1'
      expect(version('0.0.1').to_s).to eq '0.0.1'
      expect(version('0.0.0').to_s).to eq ''
      expect(version('1.0.1').to_s).to eq '1.0.1'
    end
  end
end
