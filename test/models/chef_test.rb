require 'test_helper'

class ChefTest < ActiveSupport::TestCase

	def setup
		@chef = Chef.new(chefname: 'Marco', email: 'marco@example.com')
	end

	test "chef should be valid" do
		assert @chef.valid?
	end

	test "name should be present" do
		@chef.chefname = " "
		assert_not @chef.valid?
	end

	test "email should be present" do
		@chef.email = " "
		assert_not @chef.valid?
	end

	test "name should be max 20 char" do
		@chef.chefname = "a" * 21
		assert_not @chef.valid?
	end

	test "chefname should be min 5 char" do
		@chef.chefname = "a" * 4
		assert_not @chef.valid?
	end	

	test "email adress accept valid format" do
		valid_emails = %w[user@example.com MASHUR@email.com M.First@yahoo.ca jogh+smith@co.uk.org]
		valid_emails.each do |valids|
			@chef.email = valids
			assert @chef.valid?, "#{valids.inspect} should be valid"
		end
	end

	test "should reject invalid emails" do
		invalid_emails = %w[asdasdasdasdm dasdasdasd.com@dasdasd -*/*-*/@-*/*-.com asdasdasdas.org]
		invalid_emails.each do |invalids|
			@chef.email = invalids
			assert_not @chef.valid?, "#{invalids.inspect} should be invalid"
		end
	end

	test "email should be unique and case insensitive" do
		duplicate_chef = @chef.dup
		duplicate_chef.email = @chef.email.upcase
		@chef.save
		assert_not duplicate_chef.valid?
	end

	test "email should be lowercase before db" do
		mixed_email = "JoHn@eXample.com"
		@chef.email = mixed_email
		@chef.save
		assert_equal mixed_email.downcase, @chef.reload.email

	end

end