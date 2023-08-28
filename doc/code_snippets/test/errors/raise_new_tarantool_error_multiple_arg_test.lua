local status, err = pcall(function()
    -- snippet_start
    local custom_error = box.error.new(box.error.CREATE_SPACE, 'my_space', 'the space already exists')

    box.error(custom_error)
    --[[
    ---
    - error: 'Failed to create space ''my_space'': the space already exists'
    ...
    --]]
    -- snippet_end
end)

-- Tests
local luatest = require('luatest')
local test_group = luatest.group()
test_group.test_tarantool_error_is_raised = function()
    luatest.assert_equals(err:unpack().message, "Failed to create space 'my_space': the space already exists")
end
