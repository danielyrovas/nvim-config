---@diagnostic disable: undefined-global

return {
    s("lf", {
        t "local ",
        i(1),
        t " = function() ",
        i(2),
        t " end",
        i(0),
    }),
    s("fn", {
        t "function() ",
        i(1),
        t " end",
        i(0),
    }),
}
