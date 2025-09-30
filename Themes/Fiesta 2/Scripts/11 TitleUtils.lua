titleList = {
        [1] = "Beginner",
        [10] = "Intermediate Lv. 1",
        [11] = "Intermediate Lv. 2",
        [12] = "Intermediate Lv. 3",
        [13] = "Intermediate Lv. 4",
        [14] = "Intermediate Lv. 5",
        [15] = "Intermediate Lv. 6",
        [16] = "Intermediate Lv. 7",
        [17] = "Intermediate Lv. 8",
        [18] = "Intermediate Lv. 9",
        [19] = "Intermediate Lv. 10",
        [20] = "Advanced Lv. 1",
        [21] = "Advanced Lv. 2",
        [22] = "Advanced Lv. 3",
        [23] = "Advanced Lv. 4",
        [24] = "Advanced Lv. 5",
        [25] = "Advanced Lv. 6",
        [26] = "Advanced Lv. 7",
        [27] = "Advanced Lv. 8",
        [28] = "Advanced Lv. 9",
        [29] = "Advanced Lv. 10",
        [30] = "[F]antastic Player",
        [40] = "[D]azzling Player",
        [50] = "[C]apable Player",
        [60] = "[B]est Player",
        [70] = "[A]ce Player",
        [80] = "[S]uper Man",
        [90] = "[SS]uper Man",
        [95] = "[SSS]uper Man",
        [99] = "The Master"
}

function GetPlayerTitle(pn)
    local keys = {}
    for k in pairs(titleList) do
        table.insert(keys,k)
    end

    local player_lvl = math.floor(1+(0.15*PROFILEMAN:GetProfile(pn):GetVoomax()^0.5))

    for i=#keys, 1, -1 do
        local k = keys[i]
        if player_lvl <= k then
            return titleList[k]
        end
    end

    return "Beginner"
end