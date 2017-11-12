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
      lifegame = LifeGame.new
      5.times do |i|
        5.times do |j|
          expect(lifegame.cells[i][j]).to eq false
        end
      end
    end

    it "ブリンカーで生成する" do
      living_cells = [{ x: 2, y: 3 }, { x: 3, y: 3 }, { x: 4, y: 3 }]
      lifegame = LifeGame.new(living_cells)
      results = [
        [false, false, false, false, false],
        [false, false, false, false, false],
        [false, true, true, true, false],
        [false, false, false, false, false],
        [false, false, false, false, false],
      ]
      lifegame.cells.each_with_index do |cells, i|
        expect(cells == results[i]).to be_truthy
      end
    end
  end
end
