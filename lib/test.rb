=begin
def cross?(axis)
  count = 0
  prev_disc = nil

  axis.each do |disc|
    if prev_disc == disc && !disc.nil?
      count += 1
    end
    if disc.nil? || disc == ' '
      count = 0
      prev_disc = disc
      next
    end
    if disc != prev_disc && !prev_disc.nil?
      count = 1
      prev_disc = disc
    end
    if disc != prev_disc && prev_disc.nil?
      count += 1
    end
    return true if count == 4
  end
  false
end
=end


def cross?(axis)
  count = 0
  prev = nil

  axis.each do |disc|
    if prev.nil?
      prev = disc
      count += 1
      next
    end

    if prev == disc
      count += 1
      return true if count == 4
      next
    end

    if prev != disc
      count = 1
    end
  end
  p count
end

cross?(['x', 'x'])

