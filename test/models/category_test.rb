class CategoryTest < ActiveSupport::TestCase

test "category shoul be created" do
    @category = Category.new(name: "Hospital")
    assert @category.valid?
end

end