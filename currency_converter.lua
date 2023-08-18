script_author("d1yorhay")
script_name("Currency Converter")
script_description("Конвертер валют для ARIZONA RP.")
script_version("0.1 alpha")

local imgui = require('imgui')
local sampev = require("lib.samp.events")
local sw, sh = getScreenResolution()
local encoding = require("encoding")
local tab = 0
local BTC_window = 0
encoding.default = "CP1251"
u8 = encoding.UTF8

local LTC = ""
local ETH = ""
local euro = ""
local ASC = ""
local VC_buy = ""
local VC_sell = ""
local output = "0"
local text_cur = ""
local samp = ""
local ShowCursor = false
local main_window_state = imgui.ImBool(false)
local input1 = imgui.ImBuffer(256)
local input2 = imgui.ImBuffer(256)
--BTC BUY
local output_BTC_SA_buy = ""
local output_SA_BTC_buy = ""
--BTC SELL
local output_BTC_SA_sell = ""
local output_SA_BTC_sell = ""
--LTC BUY
local output_LTC_SA_buy = ""
local output_SA_LTC_buy = ""
--LTC SELL
local output_LTC_SA_sell = ""
local output_SA_LTC_sell = ""
--ETH
local output_ETH_SA = ""
local output_SA_ETH = ""
--EUR
local output_EUR_SA = ""
local output_SA_EUR = ""
--ASC BUY
local output_ASC_SA_buy = ""
local output_SA_ASC_buy = ""
--ASC SELL
local output_ASC_SA_sell = ""
local output_SA_ASC_sell = ""
--VC$ BUY
local output_VC_SA_buy = ""
local output_SA_VC_buy = ""
--VC$ SELL
local output_VC_SA_sell = ""
local output_SA_VC_sell = ""

local output_VC_SA_buy1 = ""

function round(num)
    local under = math.floor(num)
    local upper = under + 1
    local under_diff = num - under
    local upper_diff = upper - num
    if upper_diff < under_diff then
        return upper
    else
        return under
    end
end

function main()
    if not isSampLoaded() or not isSampLoaded() then return end
    while not isSampAvailable() do wait(100) end
    sampAddChatMessage("{ff7d00}[Currency Converter] {ffffff}Скрипт {ff7d00}Currency Converter {ffffff}успешно загружен!", -1)
    sampAddChatMessage("{ff7d00}[Currency Converter] {ffffff}Для активации/деактивации скрипта используйте {ff7d00}/convert", -1)
    sampAddChatMessage("{ff7d00}[Currency Converter] {ffffff}Для активации/деактивации курсора используйте {ff7d00}/mouse", -1)
    sampAddChatMessage("{ff7d00}[Currency Converter] {ffffff}Автор {ff7d00}d1yorhay. {ffffff}Связь с разработчиком {00ffff}Telegram: @d1yorhay", -1)

    imgui.Process = false
    imgui.ShowCursor = false
    
    sampRegisterChatCommand('mouse', mouse)
    sampRegisterChatCommand("convert", convert)

    while true do
        wait(0)
        if main_window_state.v == false then
            imgui.Process = false
        end
    end
end

function sampev.onShowDialog(dialogId, style, title, button1, button2, text)
    if title == "{BFBBBA}Курс валют (USD)" then
        BTC = text
        LTC = text
        ETH = text
        EUR = text
        ASC = text
        VC = text
    end
end

function mouse()
    ShowCursor = not ShowCursor
    imgui.ShowCursor = ShowCursor
end

function refresh()
    lua_thread.create(function()
        sampAddChatMessage("{3d85c6}[ИНФО] {ff7d00}[Currency Converter] {ffffff}Пожалуйста подождите когда загрузятся курсы валют.", -1)
        sampSendChat('/settings')
        wait(200)
        sampSendDialogResponse(26036, 1, 14, 0)
        wait(200)
        sampSendDialogResponse(966, 1, 11, 0)
        wait(200)
        sampSendDialogResponse(25829, 1, 11, 0)
        sampSendChat('/phone')
        wait(200)
        setVirtualKeyDown (0x1B, true)
        wait (5)
        setVirtualKeyDown (0x1B, false)
        wait(200)
        sampSendChat('/settings')
        wait(200)
        sampSendDialogResponse(26036, 1, 14, 0)
        wait(200)
        sampSendDialogResponse(966, 1, 11, 0)
        wait(200)
        sampSendDialogResponse(25829, 1, 17, 0)
        wait(200)
        sampCloseCurrentDialogWithButton()
        sampAddChatMessage("{3d85c6}[ИНФО] {ff7d00}[Currency Converter] {ffffff}Курсы валют {8fce00}успешно {ffffff}загружены!", -1)
        imgui.ShowCursor = true
    end)
end

function convert(arg)
    sampAddChatMessage("{3d85c6}[ИНФО] {ffffff}Для активации/деактивации курсора используйте {ff7d00}/mouse", -1)
    refresh()
    tab = 0
    main_window_state.v = not main_window_state.v
    imgui.Process = main_window_state.v
end

function imgui.TextQuestion(label, description)
    imgui.TextDisabled(label)

    if imgui.IsItemHovered() then
        imgui.BeginTooltip()
            imgui.PushTextWrapPos(600)
                imgui.TextUnformatted(description)
            imgui.PopTextWrapPos()
        imgui.EndTooltip()
    end
end

function imgui.OnDrawFrame()
    imgui.SetNextWindowSize(imgui.ImVec2(300, 200))
    imgui.SetNextWindowPos(imgui.ImVec2((sw / 2.4), sh / 3))
    imgui.Begin("Currency Converter by d1yorhay", main_window_state, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoScrollbar)

    imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0, 0, 164, 1))

    if imgui.Button('BTC', imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize("BTC").x) / 2 - 100)) then
        tab = 1
    end
    imgui.SameLine()
    if imgui.Button('LTC', imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize("LTC").x) / 2 - 60)) then
        tab = 2
    end
    imgui.SameLine()
    if imgui.Button('ETH', imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize("ETH").x) / 2 - 20)) then
        tab = 3
    end
    imgui.SameLine()
    if imgui.Button('EUR', imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize("EUR").x) / 2 + 20)) then
        tab = 4
    end
    imgui.SameLine()
    if imgui.Button('ASC', imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize("ASC").x) / 2 + 60)) then
        tab = 5
    end
    imgui.SameLine()
    if imgui.Button('VC$', imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize("VC$").x) / 2 + 100)) then
        tab = 6
    end

    imgui.NewLine()
    imgui.PopStyleColor()

    if tab == 0 then
        imgui.BeginChild('NIL', imgui.ImVec2(280, 120), true)
        imgui.TextColored(imgui.ImVec4(0, 255, 0, 1), u8("Пожалуйста, укажите"), imgui.SetCursorPosX(80), imgui.SetCursorPosY(30))
        imgui.TextColored(imgui.ImVec4(0, 255, 0, 1), u8("нужную вам валюту"), imgui.SetCursorPosX(85))
        imgui.TextColored(imgui.ImVec4(0, 255, 0, 1), u8("из списка выше"), imgui.SetCursorPosX(95))
        imgui.EndChild()

    elseif tab == 1 then
        imgui.BeginChild('BTC', imgui.ImVec2(280, 120), true)
        imgui.NewLine()
        imgui.TextColored(imgui.ImVec4(0, 255, 0, 1), u8("Вы хотите КУПИТЬ или ПРОДАТЬ валюту BTC?"), imgui.SetCursorPosX(5))
        imgui.NewLine()
            if imgui.Button(u8"КУПИТЬ BTC", imgui.SetCursorPosX(45)) then
                tab = 7
            end
            imgui.SameLine()
            if imgui.Button(u8"ПРОДАТЬ BTC", imgui.SetCursorPosX(150)) then
                tab = 8
            end
        imgui.EndChild()
    elseif tab == 2 then
        imgui.BeginChild('LTC', imgui.ImVec2(280, 120), true)
        imgui.InputText(u8"СALС BUY LTC", input1, imgui.SetCursorPosX(5))
        imgui.SameLine()
        if imgui.Button(u8"СALС BUY LTС", imgui.SetCursorPosX(187)) then
            input_num = tonumber(input1.v)
            if input_num == nil then
                sampAddChatMessage("{CF4A49}[ОШИБКА!] {ff7d00}[Currency Converter] {ffffff}Укажите значение!", -1)
            else
                output_LTC_SA_buy = tostring(input_num * tonumber(string.match(LTC, "[(LTC):{cccccc}$]+(%d+)%s+[{cccccc}Ethereum]+"))):reverse():gsub("(%d%d%d)", "%1."):reverse()
            end
        end
        imgui.TextColored(imgui.ImVec4(66, 255, 69, 1),u8("LTC to SA$: " .. output_LTC_SA_buy), imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(output_LTC_SA_buy).x) / 3.5))
        imgui.SameLine()
        imgui.TextQuestion("( ? )", u8"Пример использования: Вам нужно узнать сколько будет 15 LTC в SA$ введите число 15 в строку выше и Вам выведется результат в SA$")
        imgui.InputText(u8"CALС ВUY LTC", input2, imgui.SetCursorPosX(5))
        imgui.SameLine()
        if imgui.Button(u8"CALC ВUY LTС", imgui.SetCursorPosX(187)) then
            input_num = tonumber(input2.v)
            if input_num == nil then
                sampAddChatMessage("{CF4A49}[ОШИБКА!] {ff7d00}[Currency Converter] {ffffff}Укажите значение!", -1)
            else
                output_SA_LTC_buy = tostring(round(input_num / tonumber(string.match(LTC, "[(LTC):{cccccc}$]+(%d+)%s+[{cccccc}Ethereum]+")))):reverse():gsub("(%d%d%d)", "%1."):reverse()
            end
        end
        imgui.TextColored(imgui.ImVec4(66, 255, 69, 1),u8("SA$ to LTC: " .. output_SA_LTC_buy), imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(output_SA_LTC_buy).x) / 3.5))
        imgui.SameLine()
        imgui.TextQuestion("( ? )", u8"Пример использования: Вам нужно узнать сколько будет 5.000.000 SA$ в LTC введите число 5.000.000 в строку выше и Вам выведется результат в LTC")
        if imgui.Button(u8"ЗАКРЫТЬ", imgui.SetCursorPosX(100)) then
            tab = 0
        end
        imgui.EndChild()
    elseif tab == 3 then
        imgui.BeginChild('ETH', imgui.ImVec2(280, 120), true)
        imgui.InputText(u8"СALС BUY ETH", input1, imgui.SetCursorPosX(5))
        imgui.SameLine()
        if imgui.Button(u8"САLС BUY ETH", imgui.SetCursorPosX(187)) then
            input_num = tonumber(input1.v)
            if input_num == nil then
                sampAddChatMessage("{CF4A49}[ОШИБКА!] {ff7d00}[Currency Converter] {ffffff}Укажите значение!", -1)
            else
                output_ETH_SA = tostring(input_num * tonumber(string.match(ETH:gsub("ЕВРО", "EUR"), u8"[(ETH):{cccccc}$]+(%d+)%s+[EUR]+"))):reverse():gsub("(%d%d%d)", "%1."):reverse()
            end
        end
        imgui.TextColored(imgui.ImVec4(66, 255, 69, 1),u8("ETH to SA$: " .. output_ETH_SA), imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(output_ETH_SA).x) / 3.5))
        imgui.SameLine()
        imgui.TextQuestion("( ? )", u8"Пример использования: Вам нужно узнать сколько будет 15 ETH в SA$ введите число 15 в строку выше и Вам выведется результат в SA$")
        imgui.InputText(u8"CALС ВUY ETH", input2, imgui.SetCursorPosX(5))
        imgui.SameLine()
        if imgui.Button(u8"CALC ВUY ETH", imgui.SetCursorPosX(187)) then
            input_num = tonumber(input2.v)
            if input_num == nil then
                sampAddChatMessage("{CF4A49}[ОШИБКА!] {ff7d00}[Currency Converter] {ffffff}Укажите значение!", -1)
            else
                output_SA_ETH = tostring(round(input_num / tonumber(string.match(ETH:gsub("ЕВРО", "EUR"), u8"[(ETH):{cccccc}$]+(%d+)%s+[EUR]+")))):reverse():gsub("(%d%d%d)", "%1."):reverse()
            end
        end
        imgui.TextColored(imgui.ImVec4(66, 255, 69, 1),u8("SA$ to ETH: " .. output_SA_ETH), imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(output_SA_ETH).x) / 3.5))
        imgui.SameLine()
        imgui.TextQuestion("( ? )", u8"Пример использования: Вам нужно узнать сколько будет 5.000.000 SA$ в ETH введите число 5.000.000 в строку выше и Вам выведется результат в ETH")
        if imgui.Button(u8"ЗАКРЫТЬ", imgui.SetCursorPosX(100)) then
            tab = 0
        end
        imgui.EndChild()
    elseif tab == 4 then
        imgui.BeginChild('EUR', imgui.ImVec2(280, 120), true)
        imgui.InputText(u8"СALС BUY ЕUR", input1, imgui.SetCursorPosX(5))
        imgui.SameLine()
        if imgui.Button(u8"САLС BUY EUR", imgui.SetCursorPosX(187)) then
            input_num = tonumber(input1.v)
            if input_num == nil then
                sampAddChatMessage("{CF4A49}[ОШИБКА!] {ff7d00}[Currency Converter] {ffffff}Укажите значение!", -1)
            else
                output_EUR_SA = tostring(input_num * tonumber(string.match(EUR, u8"[(euro):$]+(%d+)%s+[Arizona]+"))):reverse():gsub("(%d%d%d)", "%1."):reverse()
            end
        end
        imgui.TextColored(imgui.ImVec4(66, 255, 69, 1),u8("EUR to SA$: " .. output_EUR_SA), imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(output_EUR_SA).x) / 3.5))
        imgui.SameLine()
        imgui.TextQuestion("( ? )", u8"Пример использования: Вам нужно узнать сколько будет 15 EUR в SA$ введите число 15 в строку выше и Вам выведется результат в SA$")
        imgui.InputText(u8"CALС ВUY EUR", input2, imgui.SetCursorPosX(5))
        imgui.SameLine()
        if imgui.Button(u8"CALC ВUY EUR", imgui.SetCursorPosX(187)) then
            input_num = tonumber(input2.v)
            if input_num == nil then
                sampAddChatMessage("{CF4A49}[ОШИБКА!] {ff7d00}[Currency Converter] {ffffff}Укажите значение!", -1)
            else
                output_SA_EUR = tostring(round(input_num / tonumber(string.match(EUR, u8"[(euro):$]+(%d+)%s+[Arizona]+")))):reverse():gsub("(%d%d%d)", "%1."):reverse()
            end
        end
        imgui.TextColored(imgui.ImVec4(66, 255, 69, 1),u8("SA$ to EUR: " .. output_SA_EUR), imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(output_SA_EUR).x) / 3.5))
        imgui.SameLine()
        imgui.TextQuestion("( ? )", u8"Пример использования: Вам нужно узнать сколько будет 5.000.000 SA$ в EUR введите число 5.000.000 в строку выше и Вам выведется результат в EUR")
        if imgui.Button(u8"ЗАКРЫТЬ", imgui.SetCursorPosX(100)) then
            tab = 0
        end
        imgui.EndChild()
    elseif tab == 5 then
        imgui.BeginChild('ASC', imgui.ImVec2(280, 120), true)
        imgui.NewLine()
        imgui.TextColored(imgui.ImVec4(0, 255, 0, 1), u8("Вы хотите КУПИТЬ или ПРОДАТЬ валюту ASC?"), imgui.SetCursorPosX(5))
        imgui.NewLine()
            if imgui.Button(u8"КУПИТЬ ASC", imgui.SetCursorPosX(45)) then
                tab = 9
            end
            imgui.SameLine()
            if imgui.Button(u8"ПРОДАТЬ ASC", imgui.SetCursorPosX(150)) then
                tab = 10
            end
        imgui.EndChild()
    elseif tab == 6 then 
        imgui.BeginChild('VS$', imgui.ImVec2(280, 120), true)
        imgui.NewLine()
        imgui.TextColored(imgui.ImVec4(0, 255, 0, 1), u8("Вы хотите КУПИТЬ или ПРОДАТЬ валюту VS$?"), imgui.SetCursorPosX(5))
        imgui.NewLine()
            if imgui.Button(u8"КУПИТЬ VS$", imgui.SetCursorPosX(45)) then
                tab = 11
            end
            imgui.SameLine()
            if imgui.Button(u8"ПРОДАТЬ VS$", imgui.SetCursorPosX(150)) then
                tab = 12
            end
        imgui.EndChild()
    elseif tab == 7 then
        imgui.BeginChild(u8'CALC BUY BTC', imgui.ImVec2(280, 120), true)
        imgui.InputText(u8"CALC BUY BTС", input1, imgui.SetCursorPosX(5))
        imgui.SameLine()
        if imgui.Button(u8"CALC BUY BТC", imgui.SetCursorPosX(187)) then
            input_num = tonumber(input1.v)
            if input_num == nil then
                sampAddChatMessage("{CF4A49}[ОШИБКА!] {ff7d00}[Currency Converter] {ffffff}Укажите значение!", -1)
            else
                BTC_SA_buy = round((tonumber(string.match(BTC, "[(BTC):$]+(%d+)%s+[{31B404}]+"))) * 1.01)
                output_BTC_SA_buy = tostring(input_num * BTC_SA_buy):reverse():gsub("(%d%d%d)", "%1."):reverse()
            end
        end
        imgui.TextColored(imgui.ImVec4(66, 255, 69, 1),u8("Buy BTC to SA$: " .. output_BTC_SA_buy), imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(output_BTC_SA_buy).x) / 3.5))
        imgui.SameLine()
        imgui.TextQuestion("( ? )", u8"Пример использования: Вам нужно узнать сколько будет 15 BTC в SA$ введите число 15 в строку выше и Вам выведется результат в SA$ по курсу ПОКУПКИ BTC в банке")
        imgui.InputText(u8"CALC BUY ВTC", input2, imgui.SetCursorPosX(5))
        imgui.SameLine()
        if imgui.Button(u8"CALС BUY BTC", imgui.SetCursorPosX(187)) then
            input_num = tonumber(input2.v)
            if input_num == nil then
                sampAddChatMessage("{CF4A49}[ОШИБКА!] {ff7d00}[Currency Converter] {ffffff}Укажите значение!", -1)
            else
                SA_BTC_buy = round((tonumber(string.match(BTC, "[(BTC):$]+(%d+)%s+[{31B404}]+"))) * 1.01)
                output_SA_BTC_buy = tostring(round(input_num / round((tonumber(string.match(BTC, "[(BTC):$]+(%d+)%s+[{31B404}]+"))) * 1.01))):reverse():gsub("(%d%d%d)", "%1."):reverse()
            end
        end
        imgui.TextColored(imgui.ImVec4(66, 255, 69, 1),u8("Buy SA$ to BTC: " .. output_SA_BTC_buy), imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(output_SA_BTC_buy).x) / 3.5))
        imgui.SameLine()
        imgui.TextQuestion("( ? )", u8"Пример использования: Вам нужно узнать сколько будет 5.000.000 SA$ в BTC введите число 5.000.000 в строку выше и Вам выведется результат в BTC по курсу ПОКУПКИ BTC в банке")
        if imgui.Button(u8"ЗАКРЫТЬ", imgui.SetCursorPosX(100)) then
            tab = 0
        end
        imgui.EndChild()

    elseif tab == 8 then
        imgui.BeginChild(u8'CALC SELL BTC', imgui.ImVec2(280, 120), true)
        imgui.InputText(u8"CALC SELL BTС", input1, imgui.SetCursorPosX(5))
        imgui.SameLine()
        if imgui.Button(u8"CALC SELL BТC", imgui.SetCursorPosX(187)) then
            input_num = tonumber(input1.v)
            if input_num == nil then
                sampAddChatMessage("{CF4A49}[ОШИБКА!] {ff7d00}[Currency Converter] {ffffff}Укажите значение!", -1)
            else
                BTC_SA_buy = round((tonumber(string.match(BTC, "[(BTC):$]+(%d+)%s+[{31B404}]+"))))
                output_BTC_SA_buy = tostring(input_num * BTC_SA_buy):reverse():gsub("(%d%d%d)", "%1."):reverse()
            end
        end
        imgui.TextColored(imgui.ImVec4(66, 255, 69, 1),u8("Sell BTC to SA$: " .. output_BTC_SA_buy), imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(output_BTC_SA_buy).x) / 3.5))
        imgui.SameLine()
        imgui.TextQuestion("( ? )", u8"Пример использования: Вам нужно узнать сколько будет 15 BTC в SA$ введите число 15 в строку выше и Вам выведется результат в SA$ по курсу ПРОДАЖИ BTC в банке")
        imgui.InputText(u8"CALC SELL ВТC", input2, imgui.SetCursorPosX(5))
        imgui.SameLine()
        if imgui.Button(u8"CALC SELL BТC", imgui.SetCursorPosX(187)) then
            input_num = tonumber(input2.v)
            if input_num == nil then
                sampAddChatMessage("{CF4A49}[ОШИБКА!] {ff7d00}[Currency Converter] {ffffff}Укажите значение!", -1)
            else
                SA_BTC_buy = round((tonumber(string.match(BTC, "[(BTC):$]+(%d+)%s+[{31B404}]+"))))
                output_SA_BTC_buy = tostring(round(input_num / round((tonumber(string.match(BTC, "[(BTC):$]+(%d+)%s+[{31B404}]+"))) * 1.01))):reverse():gsub("(%d%d%d)", "%1."):reverse()
            end
        end
        imgui.TextColored(imgui.ImVec4(66, 255, 69, 1),u8("Sell SA$ to BTC: " .. output_SA_BTC_buy), imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(output_SA_BTC_buy).x) / 3.5))
        imgui.SameLine()
        imgui.TextQuestion("( ? )", u8"Пример использования: Вам нужно узнать сколько будет 5.000.000 SA$ в BTC введите число 5.000.000 в строку выше и Вам выведется результат в BTC по курсу ПРОДАЖИ BTC в банке")
        if imgui.Button(u8"ЗАКРЫТЬ", imgui.SetCursorPosX(100)) then
            tab = 0
        end
    elseif tab == 9 then
        imgui.BeginChild(u8'CALC BUY ASC', imgui.ImVec2(280, 120), true)
        imgui.InputText(u8"CALC BUY ASС", input1, imgui.SetCursorPosX(5))
        imgui.SameLine()
        if imgui.Button(u8"CALC BUY АSC", imgui.SetCursorPosX(187)) then
            input_num = tonumber(input1.v)
            if input_num == nil then
                sampAddChatMessage("{CF4A49}[ОШИБКА!] {ff7d00}[Currency Converter] {ffffff}Укажите значение!", -1)
            else
                output_ASC_SA_buy = tostring(input_num * round(tonumber(string.match(ASC:gsub("{.-}", ""):gsub("%b[]", ""):gsub("Текущий курс для покупки", "BUYVC"), "[(ASC):$]+(%d+)%s+[BUYVC]+")) * 1.10))
            end
        end
        imgui.TextColored(imgui.ImVec4(66, 255, 69, 1),u8("Buy ASC to SA$: " .. output_ASC_SA_buy), imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(output_ASC_SA_buy).x) / 3.5))
        imgui.SameLine()
        imgui.TextQuestion("( ? )", u8"Пример использования: Вам нужно узнать сколько будет 15 ASC в SA$ введите число 15 в строку выше и Вам выведется результат в SA$ по курсу ПОКУПКИ ASC в банке")
        imgui.InputText(u8"CALC ВUY ASC", input2, imgui.SetCursorPosX(5))
        imgui.SameLine()
        if imgui.Button(u8"СALС BUY ASC", imgui.SetCursorPosX(187)) then
            input_num = tonumber(input2.v)
            if input_num == nil then
                sampAddChatMessage("{CF4A49}[ОШИБКА!] {ff7d00}[Currency Converter] {ffffff}Укажите значение!", -1)
            else
                output_ASC_SA_sell = tostring(round(input_num / round(tonumber(string.match(ASC:gsub("{.-}", ""):gsub("%b[]", ""):gsub("Текущий курс для покупки", "BUYVC"), "[(ASC):$]+(%d+)%s+[BUYVC]+")) * 1.10)))
            end
        end
        imgui.TextColored(imgui.ImVec4(66, 255, 69, 1),u8("Buy SA$ to ASC: " .. output_ASC_SA_sell), imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(output_ASC_SA_sell).x) / 3.5))
        imgui.SameLine()
        imgui.TextQuestion("( ? )", u8"Пример использования: Вам нужно узнать сколько будет 5.000.000 SA$ в ASC введите число 5.000.000 в строку выше и Вам выведется результат в ASC по курсу ПОКУПКИ ASC в банке")
        if imgui.Button(u8"ЗАКРЫТЬ", imgui.SetCursorPosX(100)) then
            tab = 0
        end
        imgui.EndChild()
    elseif tab == 10 then
        imgui.BeginChild(u8'CALC SELL ASC', imgui.ImVec2(280, 120), true)
        imgui.InputText(u8"CALC SELL ASС", input1, imgui.SetCursorPosX(5))
        imgui.SameLine()
        if imgui.Button(u8"CALC SELL АSС", imgui.SetCursorPosX(187)) then
            input_num = tonumber(input1.v)
            if input_num == nil then
                sampAddChatMessage("{CF4A49}[ОШИБКА!] {ff7d00}[Currency Converter] {ffffff}Укажите значение!", -1)
            else
                output_ASC_SA_sell = tostring(input_num * tonumber(string.match(ASC:gsub("{.-}", ""):gsub("%b[]", ""):gsub("Текущий курс для покупки", "BUYVS"), "[(ASC):$]+(%d+)%s+[BUYVS]+")))
            end
        end
        imgui.TextColored(imgui.ImVec4(66, 255, 69, 1),u8("Sell ASC to SA$: " .. output_ASC_SA_sell), imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(output_ASC_SA_sell).x) / 3.5))
        imgui.SameLine()
        imgui.TextQuestion("( ? )", u8"Пример использования: Вам нужно узнать сколько будет 15 ASC в SA$ введите число 15 в строку выше и Вам выведется результат в SA$ по курсу ПРОДАЖИ ASC в банке")
        imgui.InputText(u8"CALC SELL АSC", input2, imgui.SetCursorPosX(5))
        imgui.SameLine()
        if imgui.Button(u8"СALС SELL АSC", imgui.SetCursorPosX(187)) then
            input_num = tonumber(input2.v)
            if input_num == nil then
                sampAddChatMessage("{CF4A49}[ОШИБКА!] {ff7d00}[Currency Converter] {ffffff}Укажите значение!", -1)
            else
                output_SA_ASC_sell = tostring(round(input_num / round(tonumber(string.match(ASC:gsub("{.-}", ""):gsub("%b[]", ""):gsub("Текущий курс для покупки", "BUYVS"), "[(ASC):$]+(%d+)%s+[BUYVS]+")))))
            end
        end
        imgui.TextColored(imgui.ImVec4(66, 255, 69, 1),u8("Sell SA$ to ASC: " .. output_SA_ASC_sell), imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(output_SA_ASC_sell).x) / 3.5))
        imgui.SameLine()
        imgui.TextQuestion("( ? )", u8"Пример использования: Вам нужно узнать сколько будет 5.000.000 SA$ в ASC введите число 5.000.000 в строку выше и Вам выведется результат в BTC по курсу ПРОДАЖИ ASC в банке")
        if imgui.Button(u8"ЗАКРЫТЬ", imgui.SetCursorPosX(100)) then
            tab = 1
        end
        imgui.EndChild()
    elseif tab == 11 then
        imgui.BeginChild(u8'CALC BUY VC$', imgui.ImVec2(280, 120), true)
        imgui.InputText(u8"CALC BUY VС$", input1, imgui.SetCursorPosX(5))
        imgui.SameLine()
        if imgui.Button(u8"CALC ВUY VС$", imgui.SetCursorPosX(187)) then
            input_num = tonumber(input1.v)
            if input_num == nil then
                sampAddChatMessage("{CF4A49}[ОШИБКА!] {ff7d00}[Currency Converter] {ffffff}Укажите значение!", -1)
            else
                output_VC_SA_buy = string.match(VC:gsub("{.-}", ""):gsub("%b[]", ""):gsub("Текущий курс для покупки", "BUYVC"):gsub("Текущий курс для продажи", "SELLVC"):gsub("/ VC$1", " "):gsub(":", ""):gsub("%$", " "), "[BUYVC]+%s+(%d+)%s+[SELLVC]+")
            end
        end
        imgui.TextColored(imgui.ImVec4(66, 255, 69, 1),u8("Buy VC$ to SA$: " .. output_VC_SA_buy), imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(output_VC_SA_buy).x) / 3.5))
        imgui.SameLine()
        imgui.TextQuestion("( ? )", u8"Пример использования: Вам нужно узнать сколько будет 15 VC$ в SA$ введите число 15 в строку выше и Вам выведется результат в SA$ по курсу ПОКУПКИ VC$ в аэропорту")
        imgui.InputText(u8"CALС SELL VС$", input2, imgui.SetCursorPosX(5))
        imgui.SameLine()
        if imgui.Button(u8"СALС SЕLL VС$", imgui.SetCursorPosX(187)) then
            input_num = tonumber(input2.v)
            if input_num == nil then
                sampAddChatMessage("{CF4A49}[ОШИБКА!] {ff7d00}[Currency Converter] {ffffff}Укажите значение!", -1)
            else
                print(VC)
                output_SA_VC_buy = tostring(round(input_num / (tonumber(string.match(VC:gsub("{.-}", ""):gsub("%b[]", ""):gsub("Текущий курс для покупки", "BUYVC"):gsub("Текущий курс для продажи", "SELLVC"):gsub("/ VC$1", " "):gsub(":", ""):gsub("%$", " "), "[BUYVC]+%s+(%d+)%s+[SELLVC]+")))))
            end
        end
        imgui.TextColored(imgui.ImVec4(66, 255, 69, 1),u8("Buy SA$ to VC$: " .. output_SA_VC_buy), imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(output_SA_VC_buy).x) / 3.5))
        imgui.SameLine()
        imgui.TextQuestion("( ? )", u8"Пример использования: Вам нужно узнать сколько будет 5.000.000 SA$ в VC$ введите число 5.000.000 в строку выше и Вам выведется результат в SA$ по курсу ПОКУПКИ VC$ в аэропорту")
        if imgui.Button(u8"ЗАКРЫТЬ", imgui.SetCursorPosX(100)) then
            tab = 0
        end
        imgui.EndChild()
    elseif tab == 12 then
        imgui.BeginChild(u8'CALC SELL VC$', imgui.ImVec2(280, 120), true)
        imgui.InputText(u8"CALC SELL VС$", input1, imgui.SetCursorPosX(5))
        imgui.SameLine()
        if imgui.Button(u8"CALC SЕLL VС$", imgui.SetCursorPosX(187)) then
            input_num = tonumber(input1.v)
            if input_num == nil then
                sampAddChatMessage("{CF4A49}[ОШИБКА!] {ff7d00}[Currency Converter] {ffffff}Укажите значение!", -1)
            else
                output_VC_SA_sell = string.match(VC:gsub("{.-}", ""):gsub("%b[]", ""):gsub("Текущий курс для покупки", ""):gsub("Текущий курс для продажи", "SELLVC"):gsub("/ VC$1", " "):gsub(":", ""):gsub("%$", " "), "[SELLVC]+%s+(%d+)")
            end
        end
        imgui.TextColored(imgui.ImVec4(66, 255, 69, 1),u8("Sell VC$ to SA$: " .. output_VC_SA_sell), imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(output_VC_SA_sell).x) / 3.5))
        imgui.SameLine()
        imgui.TextQuestion("( ? )", u8"Пример использования: Вам нужно узнать сколько будет 15 VC$ в SA$ введите число 15 в строку выше и Вам выведется результат в SA$ по курсу ПРОДАЖИ VC$ в аэропорту")
        imgui.InputText(u8"CALС ВUY VС$", input2, imgui.SetCursorPosX(5))
        imgui.SameLine()
        if imgui.Button(u8"СALС ВUY VС$", imgui.SetCursorPosX(187)) then
            input_num = tonumber(input2.v)
            if input_num == nil then
                sampAddChatMessage("{CF4A49}[ОШИБКА!] {ff7d00}[Currency Converter] {ffffff}Укажите значение!", -1)
            else
                output_SA_VC_sell = tostring(round(input_num / (tonumber(string.match(VC:gsub("{.-}", ""):gsub("%b[]", ""):gsub("Текущий курс для покупки", ""):gsub("Текущий курс для продажи", "SELLVC"):gsub("/ VC$1", " "):gsub(":", ""):gsub("%$", " "), "[SELLVC]+%s+(%d+)")))))
            end
        end
        imgui.TextColored(imgui.ImVec4(66, 255, 69, 1),u8("Sell SA$ to VC$: " .. output_SA_VC_sell), imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(output_SA_VC_sell).x) / 3.5))
        imgui.SameLine()
        imgui.TextQuestion("( ? )", u8"Пример использования: Вам нужно узнать сколько будет 5.000.000 SA$ в VC$ введите число 5.000.000 в строку выше и Вам выведется результат в VC$ по курсу ПРОДАЖИ VC$ в аэропорту")
        if imgui.Button(u8"ЗАКРЫТЬ", imgui.SetCursorPosX(100)) then
            tab = 0
        end
        imgui.EndChild()
    end
    imgui.End()
end