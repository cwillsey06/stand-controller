local validateType = import("./validateType")

describe("validateType", function()
	it("should be a function", function()
		assert.not_nil(validateType)
		assert.equals(type(validateType), "function")
	end)

	it("should accept valid types", function()
		validateType("", 123, "number")
		validateType("", "test", "string")
		validateType("", true, "boolean")
	end)

	it("should throw on mismatched types", function()
		assert.has.errors(function()
			validateType("text", {}, "string")
		end)
	end)
end)