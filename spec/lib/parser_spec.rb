require 'spec_helper'

RSpec.describe CsvParser::Parser do

  let(:sut) { CsvParser::Parser.new }

  describe '#parse' do
    it 'returns two lines' do
      csv = "ab,cd\r\nef"
      result = sut.parse(csv)
      expect(result.length).to eq 2
      expect(result[0][0]).to eq 'ab'
      expect(result[0][1]).to eq 'cd'
      expect(result[1][0]).to eq 'ef'
    end

    context 'csv with escaped double quotes' do
      it 'returns one line and two columns' do
        csv = "\"ab,cd\""
        result = sut.parse(csv)
        expect(result.length).to eq 1
        expect(result[0][0]).to eq 'ab,cd'
      end
    end

    context 'csv with multiline fields' do
      it 'returns one line and one column' do
        csv = "\"ab,\ncd\""
        result = sut.parse(csv)
        expect(result.length).to eq 1
        expect(result[0][0]).to eq "ab,\ncd"
      end
    end

    context 'csv with no data' do
      it 'returns empty array' do
        csv = ''
        result = sut.parse(csv)
        expect(result.length).to eq 0
      end

      it 'returns 0 line' do
        csv = "\r\n"
        result = sut.parse(csv)
        expect(result.length).to eq 1
      end

      it 'returns 1 line' do
        csv = "\r\n"
        sut.skip_empty_row = true
        result = sut.parse(csv)
        expect(result.length).to eq 0
      end
    end
  end
end