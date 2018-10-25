local mt = {}

mt.info = {
    name = '引用声明',
    version = 1.0,
    author = '一中',
    description = '对只在lua中使用的对象进行引用声明，其实我并不想这样',
}

local list = {}


function mt:on_mark()
    list['H200'] = true
    return list
end

return mt
