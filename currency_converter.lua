script_author("d1yorhay")
script_name("Currency Converter")
script_description("��������� ����� ��� ARIZONA RP.")
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
    sampAddChatMessage("{ff7d00}[Currency Converter] {ffffff}������ {ff7d00}Currency Converter {ffffff}������� ��������!", -1)
    sampAddChatMessage("{ff7d00}[Currency Converter] {ffffff}��� ���������/����������� ������� ����������� {ff7d00}/convert", -1)
    sampAddChatMessage("{ff7d00}[Currency Converter] {ffffff}��� ���������/����������� ������� ����������� {ff7d00}/mouse", -1)
    sampAddChatMessage("{ff7d00}[Currency Converter] {ffffff}����� {ff7d00}d1yorhay. {ffffff}����� � ������������� {00ffff}Telegram: @d1yorhay", -1)

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
    if title == "{BFBBBA}���� ����� (USD)" then
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
        sampAddChatMessage("{3d85c6}[����] {ff7d00}[Currency Converter] {ffffff}���������� ��������� ����� ���������� ����� �����.", -1)
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
        sampAddChatMessage("{3d85c6}[����] {ff7d00}[Currency Converter] {ffffff}����� ����� {8fce00}������� {ffffff}���������!", -1)
        imgui.ShowCursor = true
    end)
end

function convert(arg)
    sampAddChatMessage("{3d85c6}[����] {ffffff}��� ���������/����������� ������� ����������� {ff7d00}/mouse", -1)
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
        imgui.TextColored(imgui.ImVec4(0, 255, 0, 1), u8("����������, �������"), imgui.SetCursorPosX(80), imgui.SetCursorPosY(30))
        imgui.TextColored(imgui.ImVec4(0, 255, 0, 1), u8("������ ��� ������"), imgui.SetCursorPosX(85))
        imgui.TextColored(imgui.ImVec4(0, 255, 0, 1), u8("�� ������ ����"), imgui.SetCursorPosX(95))
        imgui.EndChild()

    elseif tab == 1 then
        imgui.BeginChild('BTC', imgui.ImVec2(280, 120), true)
        imgui.NewLine()
        imgui.TextColored(imgui.ImVec4(0, 255, 0, 1), u8("�� ������ ������ ��� ������� ������ BTC?"), imgui.SetCursorPosX(5))
        imgui.NewLine()
            if imgui.Button(u8"������ BTC", imgui.SetCursorPosX(45)) then
                tab = 7
            end
            imgui.SameLine()
            if imgui.Button(u8"������� BTC", imgui.SetCursorPosX(150)) then
                tab = 8
            end
        imgui.EndChild()
    elseif tab == 2 then
        imgui.BeginChild('LTC', imgui.ImVec2(280, 120), true)
        imgui.InputText(u8"�AL� BUY LTC", input1, imgui.SetCursorPosX(5))
        imgui.SameLine()
        if imgui.Button(u8"�AL� BUY LT�", imgui.SetCursorPosX(187)) then
            input_num = tonumber(input1.v)
            if input_num == nil then
                sampAddChatMessage("{CF4A49}[������!] {ff7d00}[Currency Converter] {ffffff}������� ��������!", -1)
            else
                output_LTC_SA_buy = tostring(input_num * tonumber(string.match(LTC, "[(LTC):{cccccc}$]+(%d+)%s+[{cccccc}Ethereum]+"))):reverse():gsub("(%d%d%d)", "%1."):reverse()
            end
        end
        imgui.TextColored(imgui.ImVec4(66, 255, 69, 1),u8("LTC to SA$: " .. output_LTC_SA_buy), imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(output_LTC_SA_buy).x) / 3.5))
        imgui.SameLine()
        imgui.TextQuestion("( ? )", u8"������ �������������: ��� ����� ������ ������� ����� 15 LTC � SA$ ������� ����� 15 � ������ ���� � ��� ��������� ��������� � SA$")
        imgui.InputText(u8"CAL� �UY LTC", input2, imgui.SetCursorPosX(5))
        imgui.SameLine()
        if imgui.Button(u8"CALC �UY LT�", imgui.SetCursorPosX(187)) then
            input_num = tonumber(input2.v)
            if input_num == nil then
                sampAddChatMessage("{CF4A49}[������!] {ff7d00}[Currency Converter] {ffffff}������� ��������!", -1)
            else
                output_SA_LTC_buy = tostring(round(input_num / tonumber(string.match(LTC, "[(LTC):{cccccc}$]+(%d+)%s+[{cccccc}Ethereum]+")))):reverse():gsub("(%d%d%d)", "%1."):reverse()
            end
        end
        imgui.TextColored(imgui.ImVec4(66, 255, 69, 1),u8("SA$ to LTC: " .. output_SA_LTC_buy), imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(output_SA_LTC_buy).x) / 3.5))
        imgui.SameLine()
        imgui.TextQuestion("( ? )", u8"������ �������������: ��� ����� ������ ������� ����� 5.000.000 SA$ � LTC ������� ����� 5.000.000 � ������ ���� � ��� ��������� ��������� � LTC")
        if imgui.Button(u8"�������", imgui.SetCursorPosX(100)) then
            tab = 0
        end
        imgui.EndChild()
    elseif tab == 3 then
        imgui.BeginChild('ETH', imgui.ImVec2(280, 120), true)
        imgui.InputText(u8"�AL� BUY ETH", input1, imgui.SetCursorPosX(5))
        imgui.SameLine()
        if imgui.Button(u8"��L� BUY ETH", imgui.SetCursorPosX(187)) then
            input_num = tonumber(input1.v)
            if input_num == nil then
                sampAddChatMessage("{CF4A49}[������!] {ff7d00}[Currency Converter] {ffffff}������� ��������!", -1)
            else
                output_ETH_SA = tostring(input_num * tonumber(string.match(ETH:gsub("����", "EUR"), u8"[(ETH):{cccccc}$]+(%d+)%s+[EUR]+"))):reverse():gsub("(%d%d%d)", "%1."):reverse()
            end
        end
        imgui.TextColored(imgui.ImVec4(66, 255, 69, 1),u8("ETH to SA$: " .. output_ETH_SA), imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(output_ETH_SA).x) / 3.5))
        imgui.SameLine()
        imgui.TextQuestion("( ? )", u8"������ �������������: ��� ����� ������ ������� ����� 15 ETH � SA$ ������� ����� 15 � ������ ���� � ��� ��������� ��������� � SA$")
        imgui.InputText(u8"CAL� �UY ETH", input2, imgui.SetCursorPosX(5))
        imgui.SameLine()
        if imgui.Button(u8"CALC �UY ETH", imgui.SetCursorPosX(187)) then
            input_num = tonumber(input2.v)
            if input_num == nil then
                sampAddChatMessage("{CF4A49}[������!] {ff7d00}[Currency Converter] {ffffff}������� ��������!", -1)
            else
                output_SA_ETH = tostring(round(input_num / tonumber(string.match(ETH:gsub("����", "EUR"), u8"[(ETH):{cccccc}$]+(%d+)%s+[EUR]+")))):reverse():gsub("(%d%d%d)", "%1."):reverse()
            end
        end
        imgui.TextColored(imgui.ImVec4(66, 255, 69, 1),u8("SA$ to ETH: " .. output_SA_ETH), imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(output_SA_ETH).x) / 3.5))
        imgui.SameLine()
        imgui.TextQuestion("( ? )", u8"������ �������������: ��� ����� ������ ������� ����� 5.000.000 SA$ � ETH ������� ����� 5.000.000 � ������ ���� � ��� ��������� ��������� � ETH")
        if imgui.Button(u8"�������", imgui.SetCursorPosX(100)) then
            tab = 0
        end
        imgui.EndChild()
    elseif tab == 4 then
        imgui.BeginChild('EUR', imgui.ImVec2(280, 120), true)
        imgui.InputText(u8"�AL� BUY �UR", input1, imgui.SetCursorPosX(5))
        imgui.SameLine()
        if imgui.Button(u8"��L� BUY EUR", imgui.SetCursorPosX(187)) then
            input_num = tonumber(input1.v)
            if input_num == nil then
                sampAddChatMessage("{CF4A49}[������!] {ff7d00}[Currency Converter] {ffffff}������� ��������!", -1)
            else
                output_EUR_SA = tostring(input_num * tonumber(string.match(EUR, u8"[(euro):$]+(%d+)%s+[Arizona]+"))):reverse():gsub("(%d%d%d)", "%1."):reverse()
            end
        end
        imgui.TextColored(imgui.ImVec4(66, 255, 69, 1),u8("EUR to SA$: " .. output_EUR_SA), imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(output_EUR_SA).x) / 3.5))
        imgui.SameLine()
        imgui.TextQuestion("( ? )", u8"������ �������������: ��� ����� ������ ������� ����� 15 EUR � SA$ ������� ����� 15 � ������ ���� � ��� ��������� ��������� � SA$")
        imgui.InputText(u8"CAL� �UY EUR", input2, imgui.SetCursorPosX(5))
        imgui.SameLine()
        if imgui.Button(u8"CALC �UY EUR", imgui.SetCursorPosX(187)) then
            input_num = tonumber(input2.v)
            if input_num == nil then
                sampAddChatMessage("{CF4A49}[������!] {ff7d00}[Currency Converter] {ffffff}������� ��������!", -1)
            else
                output_SA_EUR = tostring(round(input_num / tonumber(string.match(EUR, u8"[(euro):$]+(%d+)%s+[Arizona]+")))):reverse():gsub("(%d%d%d)", "%1."):reverse()
            end
        end
        imgui.TextColored(imgui.ImVec4(66, 255, 69, 1),u8("SA$ to EUR: " .. output_SA_EUR), imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(output_SA_EUR).x) / 3.5))
        imgui.SameLine()
        imgui.TextQuestion("( ? )", u8"������ �������������: ��� ����� ������ ������� ����� 5.000.000 SA$ � EUR ������� ����� 5.000.000 � ������ ���� � ��� ��������� ��������� � EUR")
        if imgui.Button(u8"�������", imgui.SetCursorPosX(100)) then
            tab = 0
        end
        imgui.EndChild()
    elseif tab == 5 then
        imgui.BeginChild('ASC', imgui.ImVec2(280, 120), true)
        imgui.NewLine()
        imgui.TextColored(imgui.ImVec4(0, 255, 0, 1), u8("�� ������ ������ ��� ������� ������ ASC?"), imgui.SetCursorPosX(5))
        imgui.NewLine()
            if imgui.Button(u8"������ ASC", imgui.SetCursorPosX(45)) then
                tab = 9
            end
            imgui.SameLine()
            if imgui.Button(u8"������� ASC", imgui.SetCursorPosX(150)) then
                tab = 10
            end
        imgui.EndChild()
    elseif tab == 6 then 
        imgui.BeginChild('VS$', imgui.ImVec2(280, 120), true)
        imgui.NewLine()
        imgui.TextColored(imgui.ImVec4(0, 255, 0, 1), u8("�� ������ ������ ��� ������� ������ VS$?"), imgui.SetCursorPosX(5))
        imgui.NewLine()
            if imgui.Button(u8"������ VS$", imgui.SetCursorPosX(45)) then
                tab = 11
            end
            imgui.SameLine()
            if imgui.Button(u8"������� VS$", imgui.SetCursorPosX(150)) then
                tab = 12
            end
        imgui.EndChild()
    elseif tab == 7 then
        imgui.BeginChild(u8'CALC BUY BTC', imgui.ImVec2(280, 120), true)
        imgui.InputText(u8"CALC BUY BT�", input1, imgui.SetCursorPosX(5))
        imgui.SameLine()
        if imgui.Button(u8"CALC BUY B�C", imgui.SetCursorPosX(187)) then
            input_num = tonumber(input1.v)
            if input_num == nil then
                sampAddChatMessage("{CF4A49}[������!] {ff7d00}[Currency Converter] {ffffff}������� ��������!", -1)
            else
                BTC_SA_buy = round((tonumber(string.match(BTC, "[(BTC):$]+(%d+)%s+[{31B404}]+"))) * 1.01)
                output_BTC_SA_buy = tostring(input_num * BTC_SA_buy):reverse():gsub("(%d%d%d)", "%1."):reverse()
            end
        end
        imgui.TextColored(imgui.ImVec4(66, 255, 69, 1),u8("Buy BTC to SA$: " .. output_BTC_SA_buy), imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(output_BTC_SA_buy).x) / 3.5))
        imgui.SameLine()
        imgui.TextQuestion("( ? )", u8"������ �������������: ��� ����� ������ ������� ����� 15 BTC � SA$ ������� ����� 15 � ������ ���� � ��� ��������� ��������� � SA$ �� ����� ������� BTC � �����")
        imgui.InputText(u8"CALC BUY �TC", input2, imgui.SetCursorPosX(5))
        imgui.SameLine()
        if imgui.Button(u8"CAL� BUY BTC", imgui.SetCursorPosX(187)) then
            input_num = tonumber(input2.v)
            if input_num == nil then
                sampAddChatMessage("{CF4A49}[������!] {ff7d00}[Currency Converter] {ffffff}������� ��������!", -1)
            else
                SA_BTC_buy = round((tonumber(string.match(BTC, "[(BTC):$]+(%d+)%s+[{31B404}]+"))) * 1.01)
                output_SA_BTC_buy = tostring(round(input_num / round((tonumber(string.match(BTC, "[(BTC):$]+(%d+)%s+[{31B404}]+"))) * 1.01))):reverse():gsub("(%d%d%d)", "%1."):reverse()
            end
        end
        imgui.TextColored(imgui.ImVec4(66, 255, 69, 1),u8("Buy SA$ to BTC: " .. output_SA_BTC_buy), imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(output_SA_BTC_buy).x) / 3.5))
        imgui.SameLine()
        imgui.TextQuestion("( ? )", u8"������ �������������: ��� ����� ������ ������� ����� 5.000.000 SA$ � BTC ������� ����� 5.000.000 � ������ ���� � ��� ��������� ��������� � BTC �� ����� ������� BTC � �����")
        if imgui.Button(u8"�������", imgui.SetCursorPosX(100)) then
            tab = 0
        end
        imgui.EndChild()

    elseif tab == 8 then
        imgui.BeginChild(u8'CALC SELL BTC', imgui.ImVec2(280, 120), true)
        imgui.InputText(u8"CALC SELL BT�", input1, imgui.SetCursorPosX(5))
        imgui.SameLine()
        if imgui.Button(u8"CALC SELL B�C", imgui.SetCursorPosX(187)) then
            input_num = tonumber(input1.v)
            if input_num == nil then
                sampAddChatMessage("{CF4A49}[������!] {ff7d00}[Currency Converter] {ffffff}������� ��������!", -1)
            else
                BTC_SA_buy = round((tonumber(string.match(BTC, "[(BTC):$]+(%d+)%s+[{31B404}]+"))))
                output_BTC_SA_buy = tostring(input_num * BTC_SA_buy):reverse():gsub("(%d%d%d)", "%1."):reverse()
            end
        end
        imgui.TextColored(imgui.ImVec4(66, 255, 69, 1),u8("Sell BTC to SA$: " .. output_BTC_SA_buy), imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(output_BTC_SA_buy).x) / 3.5))
        imgui.SameLine()
        imgui.TextQuestion("( ? )", u8"������ �������������: ��� ����� ������ ������� ����� 15 BTC � SA$ ������� ����� 15 � ������ ���� � ��� ��������� ��������� � SA$ �� ����� ������� BTC � �����")
        imgui.InputText(u8"CALC SELL ��C", input2, imgui.SetCursorPosX(5))
        imgui.SameLine()
        if imgui.Button(u8"CALC SELL B�C", imgui.SetCursorPosX(187)) then
            input_num = tonumber(input2.v)
            if input_num == nil then
                sampAddChatMessage("{CF4A49}[������!] {ff7d00}[Currency Converter] {ffffff}������� ��������!", -1)
            else
                SA_BTC_buy = round((tonumber(string.match(BTC, "[(BTC):$]+(%d+)%s+[{31B404}]+"))))
                output_SA_BTC_buy = tostring(round(input_num / round((tonumber(string.match(BTC, "[(BTC):$]+(%d+)%s+[{31B404}]+"))) * 1.01))):reverse():gsub("(%d%d%d)", "%1."):reverse()
            end
        end
        imgui.TextColored(imgui.ImVec4(66, 255, 69, 1),u8("Sell SA$ to BTC: " .. output_SA_BTC_buy), imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(output_SA_BTC_buy).x) / 3.5))
        imgui.SameLine()
        imgui.TextQuestion("( ? )", u8"������ �������������: ��� ����� ������ ������� ����� 5.000.000 SA$ � BTC ������� ����� 5.000.000 � ������ ���� � ��� ��������� ��������� � BTC �� ����� ������� BTC � �����")
        if imgui.Button(u8"�������", imgui.SetCursorPosX(100)) then
            tab = 0
        end
    elseif tab == 9 then
        imgui.BeginChild(u8'CALC BUY ASC', imgui.ImVec2(280, 120), true)
        imgui.InputText(u8"CALC BUY AS�", input1, imgui.SetCursorPosX(5))
        imgui.SameLine()
        if imgui.Button(u8"CALC BUY �SC", imgui.SetCursorPosX(187)) then
            input_num = tonumber(input1.v)
            if input_num == nil then
                sampAddChatMessage("{CF4A49}[������!] {ff7d00}[Currency Converter] {ffffff}������� ��������!", -1)
            else
                output_ASC_SA_buy = tostring(input_num * round(tonumber(string.match(ASC:gsub("{.-}", ""):gsub("%b[]", ""):gsub("������� ���� ��� �������", "BUYVC"), "[(ASC):$]+(%d+)%s+[BUYVC]+")) * 1.10))
            end
        end
        imgui.TextColored(imgui.ImVec4(66, 255, 69, 1),u8("Buy ASC to SA$: " .. output_ASC_SA_buy), imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(output_ASC_SA_buy).x) / 3.5))
        imgui.SameLine()
        imgui.TextQuestion("( ? )", u8"������ �������������: ��� ����� ������ ������� ����� 15 ASC � SA$ ������� ����� 15 � ������ ���� � ��� ��������� ��������� � SA$ �� ����� ������� ASC � �����")
        imgui.InputText(u8"CALC �UY ASC", input2, imgui.SetCursorPosX(5))
        imgui.SameLine()
        if imgui.Button(u8"�AL� BUY ASC", imgui.SetCursorPosX(187)) then
            input_num = tonumber(input2.v)
            if input_num == nil then
                sampAddChatMessage("{CF4A49}[������!] {ff7d00}[Currency Converter] {ffffff}������� ��������!", -1)
            else
                output_ASC_SA_sell = tostring(round(input_num / round(tonumber(string.match(ASC:gsub("{.-}", ""):gsub("%b[]", ""):gsub("������� ���� ��� �������", "BUYVC"), "[(ASC):$]+(%d+)%s+[BUYVC]+")) * 1.10)))
            end
        end
        imgui.TextColored(imgui.ImVec4(66, 255, 69, 1),u8("Buy SA$ to ASC: " .. output_ASC_SA_sell), imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(output_ASC_SA_sell).x) / 3.5))
        imgui.SameLine()
        imgui.TextQuestion("( ? )", u8"������ �������������: ��� ����� ������ ������� ����� 5.000.000 SA$ � ASC ������� ����� 5.000.000 � ������ ���� � ��� ��������� ��������� � ASC �� ����� ������� ASC � �����")
        if imgui.Button(u8"�������", imgui.SetCursorPosX(100)) then
            tab = 0
        end
        imgui.EndChild()
    elseif tab == 10 then
        imgui.BeginChild(u8'CALC SELL ASC', imgui.ImVec2(280, 120), true)
        imgui.InputText(u8"CALC SELL AS�", input1, imgui.SetCursorPosX(5))
        imgui.SameLine()
        if imgui.Button(u8"CALC SELL �S�", imgui.SetCursorPosX(187)) then
            input_num = tonumber(input1.v)
            if input_num == nil then
                sampAddChatMessage("{CF4A49}[������!] {ff7d00}[Currency Converter] {ffffff}������� ��������!", -1)
            else
                output_ASC_SA_sell = tostring(input_num * tonumber(string.match(ASC:gsub("{.-}", ""):gsub("%b[]", ""):gsub("������� ���� ��� �������", "BUYVS"), "[(ASC):$]+(%d+)%s+[BUYVS]+")))
            end
        end
        imgui.TextColored(imgui.ImVec4(66, 255, 69, 1),u8("Sell ASC to SA$: " .. output_ASC_SA_sell), imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(output_ASC_SA_sell).x) / 3.5))
        imgui.SameLine()
        imgui.TextQuestion("( ? )", u8"������ �������������: ��� ����� ������ ������� ����� 15 ASC � SA$ ������� ����� 15 � ������ ���� � ��� ��������� ��������� � SA$ �� ����� ������� ASC � �����")
        imgui.InputText(u8"CALC SELL �SC", input2, imgui.SetCursorPosX(5))
        imgui.SameLine()
        if imgui.Button(u8"�AL� SELL �SC", imgui.SetCursorPosX(187)) then
            input_num = tonumber(input2.v)
            if input_num == nil then
                sampAddChatMessage("{CF4A49}[������!] {ff7d00}[Currency Converter] {ffffff}������� ��������!", -1)
            else
                output_SA_ASC_sell = tostring(round(input_num / round(tonumber(string.match(ASC:gsub("{.-}", ""):gsub("%b[]", ""):gsub("������� ���� ��� �������", "BUYVS"), "[(ASC):$]+(%d+)%s+[BUYVS]+")))))
            end
        end
        imgui.TextColored(imgui.ImVec4(66, 255, 69, 1),u8("Sell SA$ to ASC: " .. output_SA_ASC_sell), imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(output_SA_ASC_sell).x) / 3.5))
        imgui.SameLine()
        imgui.TextQuestion("( ? )", u8"������ �������������: ��� ����� ������ ������� ����� 5.000.000 SA$ � ASC ������� ����� 5.000.000 � ������ ���� � ��� ��������� ��������� � BTC �� ����� ������� ASC � �����")
        if imgui.Button(u8"�������", imgui.SetCursorPosX(100)) then
            tab = 1
        end
        imgui.EndChild()
    elseif tab == 11 then
        imgui.BeginChild(u8'CALC BUY VC$', imgui.ImVec2(280, 120), true)
        imgui.InputText(u8"CALC BUY V�$", input1, imgui.SetCursorPosX(5))
        imgui.SameLine()
        if imgui.Button(u8"CALC �UY V�$", imgui.SetCursorPosX(187)) then
            input_num = tonumber(input1.v)
            if input_num == nil then
                sampAddChatMessage("{CF4A49}[������!] {ff7d00}[Currency Converter] {ffffff}������� ��������!", -1)
            else
                output_VC_SA_buy = string.match(VC:gsub("{.-}", ""):gsub("%b[]", ""):gsub("������� ���� ��� �������", "BUYVC"):gsub("������� ���� ��� �������", "SELLVC"):gsub("/ VC$1", " "):gsub(":", ""):gsub("%$", " "), "[BUYVC]+%s+(%d+)%s+[SELLVC]+")
            end
        end
        imgui.TextColored(imgui.ImVec4(66, 255, 69, 1),u8("Buy VC$ to SA$: " .. output_VC_SA_buy), imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(output_VC_SA_buy).x) / 3.5))
        imgui.SameLine()
        imgui.TextQuestion("( ? )", u8"������ �������������: ��� ����� ������ ������� ����� 15 VC$ � SA$ ������� ����� 15 � ������ ���� � ��� ��������� ��������� � SA$ �� ����� ������� VC$ � ���������")
        imgui.InputText(u8"CAL� SELL V�$", input2, imgui.SetCursorPosX(5))
        imgui.SameLine()
        if imgui.Button(u8"�AL� S�LL V�$", imgui.SetCursorPosX(187)) then
            input_num = tonumber(input2.v)
            if input_num == nil then
                sampAddChatMessage("{CF4A49}[������!] {ff7d00}[Currency Converter] {ffffff}������� ��������!", -1)
            else
                print(VC)
                output_SA_VC_buy = tostring(round(input_num / (tonumber(string.match(VC:gsub("{.-}", ""):gsub("%b[]", ""):gsub("������� ���� ��� �������", "BUYVC"):gsub("������� ���� ��� �������", "SELLVC"):gsub("/ VC$1", " "):gsub(":", ""):gsub("%$", " "), "[BUYVC]+%s+(%d+)%s+[SELLVC]+")))))
            end
        end
        imgui.TextColored(imgui.ImVec4(66, 255, 69, 1),u8("Buy SA$ to VC$: " .. output_SA_VC_buy), imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(output_SA_VC_buy).x) / 3.5))
        imgui.SameLine()
        imgui.TextQuestion("( ? )", u8"������ �������������: ��� ����� ������ ������� ����� 5.000.000 SA$ � VC$ ������� ����� 5.000.000 � ������ ���� � ��� ��������� ��������� � SA$ �� ����� ������� VC$ � ���������")
        if imgui.Button(u8"�������", imgui.SetCursorPosX(100)) then
            tab = 0
        end
        imgui.EndChild()
    elseif tab == 12 then
        imgui.BeginChild(u8'CALC SELL VC$', imgui.ImVec2(280, 120), true)
        imgui.InputText(u8"CALC SELL V�$", input1, imgui.SetCursorPosX(5))
        imgui.SameLine()
        if imgui.Button(u8"CALC S�LL V�$", imgui.SetCursorPosX(187)) then
            input_num = tonumber(input1.v)
            if input_num == nil then
                sampAddChatMessage("{CF4A49}[������!] {ff7d00}[Currency Converter] {ffffff}������� ��������!", -1)
            else
                output_VC_SA_sell = string.match(VC:gsub("{.-}", ""):gsub("%b[]", ""):gsub("������� ���� ��� �������", ""):gsub("������� ���� ��� �������", "SELLVC"):gsub("/ VC$1", " "):gsub(":", ""):gsub("%$", " "), "[SELLVC]+%s+(%d+)")
            end
        end
        imgui.TextColored(imgui.ImVec4(66, 255, 69, 1),u8("Sell VC$ to SA$: " .. output_VC_SA_sell), imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(output_VC_SA_sell).x) / 3.5))
        imgui.SameLine()
        imgui.TextQuestion("( ? )", u8"������ �������������: ��� ����� ������ ������� ����� 15 VC$ � SA$ ������� ����� 15 � ������ ���� � ��� ��������� ��������� � SA$ �� ����� ������� VC$ � ���������")
        imgui.InputText(u8"CAL� �UY V�$", input2, imgui.SetCursorPosX(5))
        imgui.SameLine()
        if imgui.Button(u8"�AL� �UY V�$", imgui.SetCursorPosX(187)) then
            input_num = tonumber(input2.v)
            if input_num == nil then
                sampAddChatMessage("{CF4A49}[������!] {ff7d00}[Currency Converter] {ffffff}������� ��������!", -1)
            else
                output_SA_VC_sell = tostring(round(input_num / (tonumber(string.match(VC:gsub("{.-}", ""):gsub("%b[]", ""):gsub("������� ���� ��� �������", ""):gsub("������� ���� ��� �������", "SELLVC"):gsub("/ VC$1", " "):gsub(":", ""):gsub("%$", " "), "[SELLVC]+%s+(%d+)")))))
            end
        end
        imgui.TextColored(imgui.ImVec4(66, 255, 69, 1),u8("Sell SA$ to VC$: " .. output_SA_VC_sell), imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(output_SA_VC_sell).x) / 3.5))
        imgui.SameLine()
        imgui.TextQuestion("( ? )", u8"������ �������������: ��� ����� ������ ������� ����� 5.000.000 SA$ � VC$ ������� ����� 5.000.000 � ������ ���� � ��� ��������� ��������� � VC$ �� ����� ������� VC$ � ���������")
        if imgui.Button(u8"�������", imgui.SetCursorPosX(100)) then
            tab = 0
        end
        imgui.EndChild()
    end
    imgui.End()
end