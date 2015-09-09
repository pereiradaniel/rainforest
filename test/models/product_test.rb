require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  setup do
    @product = build(:product)
    @user = build(:user)
  end

  test "should be invalid without a name" do
    @product.name = nil
    assert_nil @product.name
    assert_equal false, @product.valid?
  end

  test "should be invalid without a description" do
    @product.description = nil
    assert_nil @product.description
    assert_equal false, @product.valid?
  end

  test "should be invalid without a price" do
    @product.price_in_cents = nil
    assert_nil @product.price_in_cents
    assert_equal false, @product.valid?
  end

  test "product price should be an integer" do
    assert_equal true, @product.price_in_cents.is_a?(Integer)
  end

  test "a product has a formatted price" do
  	assert_equal true, @product.formatted_price != nil
  end

  test "a product can have many reviews" do
  	review1 = @product.reviews.build(:comment => "Comment 1", :product_id => @product.id)
    review2 = @product.reviews.build(:comment => "Comment 2", :product_id => @product.id)

    assert_equal true, @product.reviews.length > 1
  end

  test "a product can list users that have reviewed it without duplicates" do
    review1 = @product.reviews.build(:comment => "Comment 1", :product_id => @product.id)
    review2 = @product.reviews.build(:comment => "Comment 2", :product_id => @product.id)

    review1.user = @user
    review2.user = @user

    review1.save
    review2.save

    assert_equal true, @product.list_users_review.count == 1
  end

end