require '11/solution'

describe PasswordIterator do
  it "goes from 'a' to 'b'" do
    pwd_iterator = PasswordIterator.new "a"
    expect(pwd_iterator.next_password).to eq "b"
  end

  it "goes from 'z' to 'a'" do
    pwd_iterator = PasswordIterator.new "z"
    expect(pwd_iterator.next_password).to eq "a"
  end

  it "goes from 'az' to 'ba'" do
    pwd_iterator = PasswordIterator.new "az"
    expect(pwd_iterator.next_password).to eq "ba"
  end

  it "goes from 'aa' to 'ab'" do
    pwd_iterator = PasswordIterator.new "aa"
    expect(pwd_iterator.next_password).to eq "ab"
  end
end

describe PasswordValidator do
  before :each do
    @validator = PasswordValidator.new
  end

  it "invalidates password without consecutive triplet" do
    pwd = "abbceffg"
    expect(@validator.valid? pwd).to eq false
  end

  it "invalidates password with forbidden characters" do
    pwd = "hijklmmn"
    expect(@validator.valid? pwd).to eq false
  end

  it "invalidates password with only one double char" do
    pwd = "abbcegjk"
    expect(@validator.valid? pwd).to eq false
  end
end

describe PasswordCalculator do
  it "goes from abcdefgh to abcdffaa" do
    pwd = "abcdefgh"
    expect(PasswordCalculator.next_valid pwd).to eq "abcdffaa"
  end

  it "goes from ghijklmn to ghjaabcc" do
    pwd = "ghijklmn"
    expect(PasswordCalculator.next_valid pwd).to eq "ghjaabcc"
  end

  it "solves part 1" do
    pwd = "hepxcrrq"
    expect(PasswordCalculator.next_valid pwd).to eq "hepxxyzz"
  end

  it "solves part 2" do
    pwd = "hepxxyzz"
    expect(PasswordCalculator.next_valid pwd).to eq "heqaabcc"
  end
end
