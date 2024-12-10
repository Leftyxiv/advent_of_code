class Toolbox
  def self.title_case(str)
    str.split.map(&:capitalize).join(' ')
  end

  def self.reverse_words(str)
    str.split.reverse.join(' ')
  end

  def self.flatten_once(array)
    array.reduce([]) do |acc, val|
      acc.concat(val.is_a?(Array) ? val : [val])
    end
  end

  def self.cartesian_product(arr1, arr2)
    arr1.product(arr2)
  end

  def self.greatest_common_divisor(a, b)
    b == 0 ? a : greatest_common_divisor(b, a % b)
  end

  def self.least_common_multiple(a, b)
    (a * b) / greatest_common_divisor(a, b)
  end

  def self.is_prime?(num)
    return false if num <= 1
    (2..Math.sqrt(num)).none? { |i| num % i == 0 }
  end

  def self.fibonacci(n)
    return [0] if n == 0
    return [0, 1] if n == 1

    fibs = [0, 1]
    (2..n).each do |i|
      fibs << fibs[i - 1] + fibs[i - 2]
    end
    fibs
  end

  def self.factorial(n)
    return 1 if n.zero?

    (1..n).reduce(:*)
  end

  def self.permutations(n, r)
    factorial(n) / factorial(n - r)
  end

  def self.combinations(n, r)
    factorial(n) / (factorial(r) * factorial(n - r))
  end

  def self.is_palindrome?(str)
    str == str.reverse
  end

  def self.is_anagram?(str1, str2)
    str1.chars.sort == str2.chars.sort
  end

  def self.is_pangram?(str)
    ('a'..'z').all? { |char| str.downcase.include?(char) }
  end

  def self.is_isogram?(str)
    str.downcase.chars.uniq.size == str.size
  end

  def self.is_valid_email?(str)
    str.match?(/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i)
  end

  def self.is_valid_phone_number?(str)
    str.match?(/\A\(\d{3}\)\s\d{3}-\d{4}\z/)
  end

  def self.is_valid_url?(str)
    str.match?(/\Ahttps?:\/\/[\w\-]+(\.[\w\-]+)+[/#?]?.*\z/)
  end

  def self.is_valid_ip_address?(str)
    str.match?(/\A(\d{1,3}\.){3}\d{1,3}\z/)
  end

  def self.is_valid_password?(str)
    str.match?(/\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+]).{8,}\z/)
  end

  def self.is_valid_username?(str)
    str.match?(/\A[a-z0-9_-]{3,16}\z/)
  end

  def self.is_valid_date?(str)
    str.match?(/\A\d{4}-\d{2}-\d{2}\z/)
  end

  def self.batch_process(arr, batch_size)
    arr.each_slice(batch_size) do |batch|
      yield(batch)
    end
  end
end