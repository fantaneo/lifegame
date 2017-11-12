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
end
