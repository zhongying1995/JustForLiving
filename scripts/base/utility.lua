local color_styles = {
    ['reward'] = '|cffff9900'
}

function ac.get_color_string(str, type)
    local str = tostring(str)
    if color_styles[type] then
        str = color_styles[type] .. str .. '|r'
    end
	return str
end