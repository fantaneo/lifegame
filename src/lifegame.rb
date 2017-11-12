class LifeGame
  # attr_accessor :@cells
  def initialize
    setup
    @cells[2][1] = '■'
    @cells[2][2] = '■'
    @cells[2][3] = '■'
  end

  # Cellsの初期化
  def setup
    @cells = []
    5.times do |i|
      @cells << []
      5.times do
        @cells[i] << '□'
      end
    end
  end

  def content
    lines = []
    for i in 0..4 do
      line = ''
      for j in 0..4 do
        line += @cells[i][j]
      end
      lines << line
    end
    lines.join("\n")
  end

  def next_cells
    bb = [[],[],[],[],[]]
    for i in 0..4 do
      for j in 0..4 do
        count = 0

        if @cells[i][j] == '□'
          # 誕生の場合
          count = 0
          if @cells[i-1][j-1] == '■'; count += 1 end
          if @cells[i-1][j] == '■'; count += 1 end
          if @cells[i-1][j+1] == '■'; count += 1 end
          if @cells[i][j-1] == '■'; count += 1 end
          if @cells[i][j+1] == '■'; count += 1 end
          if i < 4 && @cells[i+1][j-1] == '■'; count += 1 end
          if i < 4 && @cells[i+1][j] == '■'; count += 1 end
          if i < 4 && @cells[i+1][j+1] == '■'; count += 1 end
          if count >= 3
            bb[i][j] = '■'
          else
            bb[i][j] = '□'
          end
        end

        if @cells[i][j] == '■'
          # 生存・過疎・過密の場合
          count = 0
          if @cells[i-1][j] == '■'; count += 1 end
          if @cells[i][j-1] == '■'; count += 1 end
          if @cells[i][j+1] == '■'; count += 1 end
          if @cells[i+1][j] == '■'; count += 1 end
          if count == 2
            bb[i][j] = @cells[i][j]
          else
            bb[i][j] = '□'
          end
        end
      end
    end
    bb
  end

  def output

    yield content

    for times in 0..2
      @cells = next_cells

      yield "#{times}=========="
      for i in 0..4 do
        line = ''
        for j in 0..4 do
          line += @cells[i][j]
        end
        yield line
      end
    end
  end
end
