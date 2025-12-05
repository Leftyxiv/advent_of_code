lines = File.readlines('2025/day5/input.txt').map(&:chomp)

delimiter_index = lines.index('')
fresh_ranges = lines[0...delimiter_index].map { |r| r.split('-').map(&:to_i) }
ingredient_ids = lines[(delimiter_index + 1)..].map(&:to_i)

def in_any_range?(id, ranges)
  ranges.any? { |min, max| id >= min && id <= max }
end

def merge_ranges(ranges)
  sorted = ranges.sort_by(&:first)

  sorted.each_with_object([]) do |range, merged|
    if merged.empty? || merged.last[1] < range[0]
      merged << range.dup
    else
      merged.last[1] = [merged.last[1], range[1]].max
    end
  end
end

# Part 1: Count ingredient IDs that fall within any fresh range
part_one = ingredient_ids.count { |id| in_any_range?(id, fresh_ranges) }
puts "Part 1: #{part_one}"

# Part 2: Count total unique IDs covered by all fresh ranges
merged_ranges = merge_ranges(fresh_ranges)
part_two = merged_ranges.sum { |min, max| max - min + 1 }
puts "Part 2: #{part_two}"
