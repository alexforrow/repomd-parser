require 'repomd_parser'

RSpec.describe RepomdParser::PrimaryXmlParser do
  describe '#parse' do
    let(:expected_result) do
      [
        RepomdParser::Package.new(
          'apples-0.1-0.x86_64.rpm',
          'sha256',
          '5c4e3fa1624bd23251eecdda9c7fcefad045995a9eaed527d06dd8510cfe2851',
          :rpm
        ),
        RepomdParser::Package.new(
          'apples-0.2-0.x86_64.rpm',
          'sha256',
          'a9fdc5517f48d2b12c780deb080c8a619f3d440b0b50c2c30b5c9350352db463',
          :rpm
        ),
        RepomdParser::Package.new(
          'oranges-0.1-0.x86_64.rpm',
          'sha256',
          'a38de0c943388127b9c746e7772d694055ec255706ececd563fb55d13b01b4f3',
          :rpm
        ),
        RepomdParser::Package.new(
          'oranges-0.2-0.x86_64.rpm',
          'sha256',
          'd38a6b65326e471540ce5105677411035d437a177634a77088dfb73e34461f37',
          :rpm
        )
      ]
    end

    context 'gzipped XML' do
      let(:parsed_files) do
        described_class.new(
          file_fixture('dummy_repo/repodata/abf421e45af5cd686f050bab3d2a98e0a60d1b5ca3b07c86cb948fc1abfa675e-primary.xml.gz')
        ).parse
      end

      it 'references rpm files' do
        expect(parsed_files).to eq(expected_result)
      end
    end

    context 'plain XML' do
      let(:parsed_files) do
        described_class.new(
          file_fixture('dummy_repo/repodata/abf421e45af5cd686f050bab3d2a98e0a60d1b5ca3b07c86cb948fc1abfa675e-primary.xml')
        ).parse
      end

      it 'references rpm files' do
        expect(parsed_files).to eq(expected_result)
      end
    end
  end
end
