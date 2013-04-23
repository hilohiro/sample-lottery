# -*- encoding: utf-8 -*-
class Lottery
  def initialize(max_winners)
    throw ArgumentError.new(max_winners) unless 0 < max_winners
    @max_winners = max_winners
    @members = []
    @weights = []
  end

  def add(member, weight)
    throw ArgumentError.new('member should have value.') if member.nil?
    throw ArgumentError.new("Weight should be positive.") unless Fixnum === weight && 0 < weight
    @members << member
    @weights << @weights.last.to_i + weight
  end

  def winners
    return @members.dup if @members.size <= @max_winners
    [].tap do |r|
      while r.size < @max_winners
        r << winner_index
        r.uniq!
      end
      r.map! {|index| @members[index]}
    end
  end

  private
  def winner_index
    win = rand(@weights.last)
    @weights.each_with_index {|weight, i| return i if win < weight}
    throw RuntimeError.new('no winner')
  end
end
