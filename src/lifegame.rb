class LifeGame
  attr_reader :cells

  def initialize
    setup
    @cells[2][1] = true
    @cells[2][2] = true
    @cells[2][3] = true
  end

  # Cellsの初期化
  def setup
    @cells = []
    5.times do |i|
      @cells << []
      5.times do
        @cells[i] << false
      end
    end
  end

  def content
    lines = []
    for i in 0..4 do
      line = ''
      for j in 0..4 do
        line += @cells[i][j] ? '■' : '□'
      end
      lines << line
    end
    lines.join("\n")
  end

  def create_next_step
    bb = [[],[],[],[],[]]
    for i in 0..4 do
      for j in 0..4 do
        count = 0

        if @cells[i][j] == false
          # 誕生の場合
          count = 0
          if @cells[i-1][j-1] == true; count += 1 end
          if @cells[i-1][j] == true; count += 1 end
          if @cells[i-1][j+1] == true; count += 1 end
          if @cells[i][j-1] == true; count += 1 end
          if @cells[i][j+1] == true; count += 1 end
          if i < 4 && @cells[i+1][j-1] == true; count += 1 end
          if i < 4 && @cells[i+1][j] == true; count += 1 end
          if i < 4 && @cells[i+1][j+1] == true; count += 1 end
          if count >= 3
            bb[i][j] = true
          else
            bb[i][j] = false
          end
        end

        if @cells[i][j] == true
          # 生存・過疎・過密の場合
          count = 0
          if @cells[i-1][j] == true; count += 1 end
          if @cells[i][j-1] == true; count += 1 end
          if @cells[i][j+1] == true; count += 1 end
          if @cells[i+1][j] == true; count += 1 end
          if count == 2
            bb[i][j] = @cells[i][j]
          else
            bb[i][j] = false
          end
        end
      end
    end
    @cells = bb
  end

  def output

    yield content

    for times in 0..2
      create_next_step

      yield "#{times}=========="
      yield content
    end
  end
end
