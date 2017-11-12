require "spec_helper"
require_relative '../src/lifegame.rb'

RSpec.describe "LifeGame" do
  it "ブリンカーが出力されること" do
    lifegame = LifeGame.new
    lines = []
    lifegame.output do |line|
      lines << line + "\n"
    end
    blinker = File.read("snapshot")
    expect(lines.join("")).to eq blinker
  end

  describe "Cellsの初期化" do
    it "cellsの横数が5であること" do
      lifegame = LifeGame.new
      5.times do |i|
        expect(lifegame.cells[i].size).to eq 5
      end
    end

    it "cellsの縦数が5であること" do
      lifegame = LifeGame.new
      expect(lifegame.cells.size).to eq 5
    end

    it "すべての要素がfalseであること" do
    end
  end
end
