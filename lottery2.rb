# -*- encoding: utf-8 -*-
class Lottery
  def initialize(max_winners)
    throw ArgumentError.new(max_winners) unless 0 < max_winners
    @max_winners = max_winners
    @members = []
    @candidates = []
  end

  def add(member, weight)
    throw ArgumentError.new('member should have value.') if member.nil?
    throw ArgumentError.new("Weight should be positive.") unless Fixnum === weight && 0 < weight
    @members << member
    @candidates += [@members.size - 1] * weight
    nil
  end

  def winners
    @members.size <= @max_winners ? @members.dup : @candidates.shuffle.uniq.first(@max_winners).map {|index| @members[index] }
  end
end
