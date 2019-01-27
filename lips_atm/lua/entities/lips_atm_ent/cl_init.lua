include('shared.lua')

function ENT:Draw()

	self:DrawModel()

end

/*------------------------------------------
				  BLUR
---------------------------------------*/

local blur = Material("pp/blurscreen")
local function DrawBlur(panel, amount)
    local x, y = panel:LocalToScreen(0, 0)
    local scrW, scrH = ScrW(), ScrH()
    surface.SetDrawColor(255, 255, 255)
    surface.SetMaterial(blur)
    for i = 1, 3 do
        blur:SetFloat("$blur", (i / 3) * (amount or 6))
        blur:Recompute()
        render.UpdateScreenEffectTexture()
        surface.DrawTexturedRect(x * -1, y * -1, scrW, scrH)
    end
end

local scw = ScrW()/1366

local sch = ScrH()/768

/*------------------------------------------
				  PANEL
---------------------------------------*/

surface.CreateFont( "Lips_Atm_Font1", {   font = "borg",    size = scw * 75,  weight = 500,   blursize = 0,   scanlines = 0,  antialias = true,} )

surface.CreateFont( "Lips_Atm_Font2", {   font = "borg",    size = scw * 40,  weight = 500,   blursize = 0,   scanlines = 0,  antialias = true,} )

surface.CreateFont( "Lips_Atm_Font3", {   font = "borg",    size = scw * 30,  weight = 500,   blursize = 0,   scanlines = 0,  antialias = true,} )


net.Receive("lips_atm_openmenu", function()

	local Lips_Atm_Menu = vgui.Create("DFrame")
	Lips_Atm_Menu:SetTitle("")
	Lips_Atm_Menu:MakePopup()
	Lips_Atm_Menu:SetSize(scw * 448, sch * 300)
	Lips_Atm_Menu:Center()
	Lips_Atm_Menu:SetDraggable(false)
	Lips_Atm_Menu:ShowCloseButton(false)

    Lips_Atm_Menu.Paint = function(self, w, h)
        DrawBlur(self, 2)
        draw.RoundedBox(6, 0, 0, w, h, Color(9,46,77,255))
        draw.RoundedBox(6, 0, 0, w, h, Color(9,46,77,255))
        draw.RoundedBox(0, scw * 0, sch * 0 , scw * 448, sch * 75, Color(47,104,144,255))

        draw.RoundedBox(5, scw * 49, sch * 86 , scw * 350, sch * 3, Color(47,104,144,255))
        draw.RoundedBox(5, scw * 49, sch * 180 , scw * 350, sch * 3, Color(47,104,144,255))
        draw.SimpleText(Lips_Atm_Config.Title, "Lips_Atm_Font1", scw * 224, sch * 1, Color(255,255,255),TEXT_ALIGN_CENTER)
        draw.SimpleText(LocalPlayer():Nick(), "Lips_Atm_Font2", scw * 224, sch * 95, Color(255,255,255),TEXT_ALIGN_CENTER)
        draw.SimpleText(Lips_Atm_Config.MoneyAccount.." "..DarkRP.formatMoney( LocalPlayer():GetNWInt( "lips_atm_balance", 0 ) ), "Lips_Atm_Font2", scw * 224, sch * 130, Color(255,255,255),TEXT_ALIGN_CENTER)
    end

	local Lips_Atm_BtnClose2 = vgui.Create( "DButton", Lips_Atm_Menu ) 
    Lips_Atm_BtnClose2:SetText( "X" )
    Lips_Atm_BtnClose2:SetTextColor(Color(255,255,255))
    Lips_Atm_BtnClose2:SetFont("Trebuchet24")
    Lips_Atm_BtnClose2:SetSize( scw * 25, sch * 25 )
    Lips_Atm_BtnClose2:SetPos( scw * 423, sch * 0 ) 

    Lips_Atm_BtnClose2.Paint = function(self, w, h)
        DrawBlur(self, 2)
        draw.RoundedBox(0, 0, 0, w, h, Color(9,46,77,255))
        draw.RoundedBox(0, 0, 0, w, h, Color(9,46,77,255))
    end
    

    Lips_Atm_BtnClose2.DoClick = function()

    	Lips_Atm_Menu:Close()

	end

    local Lips_Atm_BtnDeposit = vgui.Create( "DButton", Lips_Atm_Menu ) 
    Lips_Atm_BtnDeposit:SetText( Lips_Atm_Config.TDeposit )
    Lips_Atm_BtnDeposit:SetTextColor(Color(255,255,255))
    Lips_Atm_BtnDeposit:SetFont("Lips_Atm_Font2")
    Lips_Atm_BtnDeposit:SetSize( scw * 388, sch * 35 )
    Lips_Atm_BtnDeposit:SetPos( scw * 30, sch * 200 ) 

    Lips_Atm_BtnDeposit.Paint = function(self, w, h)
        DrawBlur(self, 2)
        draw.RoundedBox(0, 0, 0, w, h, Color(47,104,144,255))
        draw.RoundedBox(0, 0, 0, w, h, Color(47,104,144,255))
    end

    Lips_Atm_BtnDeposit.DoClick = function()

    	local Lips_Atm_MenuDeposit = vgui.Create("DFrame")
		Lips_Atm_MenuDeposit:SetTitle("")
		Lips_Atm_MenuDeposit:MakePopup()
		Lips_Atm_MenuDeposit:SetSize(scw * 230, sch * 120)
		Lips_Atm_MenuDeposit:Center()
		Lips_Atm_MenuDeposit:ShowCloseButton(false)
		Lips_Atm_MenuDeposit:SetDraggable(false)

	    Lips_Atm_MenuDeposit.Paint = function(self, w, h)
	        DrawBlur(self, 2)
	        draw.RoundedBox(0, 0, 0, w, h, Color(9,46,77,255))
	        draw.RoundedBox(0, 0, 0, w, h, Color(9,46,77,255))
	    end

		local TextEntry = vgui.Create( "DTextEntry", Lips_Atm_MenuDeposit ) -- create the form as a child of frame
		TextEntry:SetPos( scw * 5, sch * 5 )
		TextEntry:SetSize( scw * 220, sch * 40 )
		TextEntry:SetFont("Lips_Atm_Font3")
		TextEntry:SetText( "100" )

	    local Lips_Atm_BtnVld1 = vgui.Create( "DButton", Lips_Atm_MenuDeposit ) 
	    Lips_Atm_BtnVld1:SetText( Lips_Atm_Config.Validate )
	    Lips_Atm_BtnVld1:SetTextColor(Color(255,255,255))
	    Lips_Atm_BtnVld1:SetFont("Lips_Atm_Font3")
	    Lips_Atm_BtnVld1:SetSize( scw * 220, sch * 25 )
	    Lips_Atm_BtnVld1:SetPos( scw * 5, sch * 55 ) 

	    Lips_Atm_BtnVld1.DoClick = function()

	    	Lips_Atm_MenuDeposit:Close()

    		if (TextEntry:GetValue()) then
				if isnumber( ( tonumber( TextEntry:GetValue() ) ) ) then
					net.Start("lips_atm_deposit")
					net.WriteInt( tonumber( TextEntry:GetValue() ), 32)
					net.SendToServer()
				end
			end

		end

	    Lips_Atm_BtnVld1.Paint = function(self, w, h)
	        DrawBlur(self, 2)
	        draw.RoundedBox(0, 0, 0, w, h, Color(47,104,144,255))
	        draw.RoundedBox(0, 0, 0, w, h, Color(47,104,144,255))
	    end

	    local Lips_Atm_BtnClose1 = vgui.Create( "DButton", Lips_Atm_MenuDeposit ) 
	    Lips_Atm_BtnClose1:SetText( Lips_Atm_Config.Close )
	    Lips_Atm_BtnClose1:SetTextColor(Color(255,255,255))
	    Lips_Atm_BtnClose1:SetFont("Lips_Atm_Font3")
	    Lips_Atm_BtnClose1:SetSize( scw * 220, sch * 25 )
	    Lips_Atm_BtnClose1:SetPos( scw * 5, sch * 87 ) 

	    Lips_Atm_BtnClose1.DoClick = function()

	    	Lips_Atm_MenuDeposit:Close()

		end

	    Lips_Atm_BtnClose1.Paint = function(self, w, h)
	        DrawBlur(self, 2)
	        draw.RoundedBox(0, 0, 0, w, h, Color(47,104,144,255))
	        draw.RoundedBox(0, 0, 0, w, h, Color(47,104,144,255))
	    end

	end


    local Lips_Atm_BtnRetirer = vgui.Create( "DButton", Lips_Atm_Menu ) 
    Lips_Atm_BtnRetirer:SetText( Lips_Atm_Config.TWithdraw )
    Lips_Atm_BtnRetirer:SetTextColor(Color(255,255,255))
    Lips_Atm_BtnRetirer:SetFont("Lips_Atm_Font2")
    Lips_Atm_BtnRetirer:SetSize( scw * 388, sch * 35 )
    Lips_Atm_BtnRetirer:SetPos( scw * 30, sch * 250 ) 

    Lips_Atm_BtnRetirer.Paint = function(self, w, h)
        DrawBlur(self, 2)
        draw.RoundedBox(0, 0, 0, w, h, Color(47,104,144,255))
        draw.RoundedBox(0, 0, 0, w, h, Color(47,104,144,255))
    end

    Lips_Atm_BtnRetirer.DoClick = function()

        local Lips_Atm_MenuRetirer = vgui.Create("DFrame")
		Lips_Atm_MenuRetirer:SetTitle("")
		Lips_Atm_MenuRetirer:MakePopup()
		Lips_Atm_MenuRetirer:SetSize(scw * 230, sch * 120)
		Lips_Atm_MenuRetirer:Center()
		Lips_Atm_MenuRetirer:ShowCloseButton(false)
		Lips_Atm_MenuRetirer:SetDraggable(false)

	    Lips_Atm_MenuRetirer.Paint = function(self, w, h)
	        DrawBlur(self, 2)
	        draw.RoundedBox(0, 0, 0, w, h, Color(9,46,77,255))
	        draw.RoundedBox(0, 0, 0, w, h, Color(9,46,77,255))
	    end

		local TextEntry = vgui.Create( "DTextEntry", Lips_Atm_MenuRetirer ) -- create the form as a child of frame
		TextEntry:SetPos( scw * 5, sch * 5 )
		TextEntry:SetSize( scw * 220, sch * 40 )
		TextEntry:SetFont("Lips_Atm_Font3")
		TextEntry:SetText( "100" )

	    local Lips_Atm_BtnVld1 = vgui.Create( "DButton", Lips_Atm_MenuRetirer ) 
	    Lips_Atm_BtnVld1:SetText( Lips_Atm_Config.Validate )
	    Lips_Atm_BtnVld1:SetTextColor(Color(255,255,255))
	    Lips_Atm_BtnVld1:SetFont("Lips_Atm_Font3")
	    Lips_Atm_BtnVld1:SetSize( scw * 220, sch * 25 )
	    Lips_Atm_BtnVld1:SetPos( scw * 5, sch * 55 ) 

	    Lips_Atm_BtnVld1.DoClick = function()

	    	Lips_Atm_MenuRetirer:Close()

    		if (TextEntry:GetValue()) then
				if isnumber( ( tonumber( TextEntry:GetValue() ) ) ) then
					net.Start("lips_atm_retirer")
					net.WriteInt( tonumber( TextEntry:GetValue() ), 32)
					net.SendToServer()
				end
			end

		end

	    Lips_Atm_BtnVld1.Paint = function(self, w, h)
	        DrawBlur(self, 2)
	        draw.RoundedBox(0, 0, 0, w, h, Color(47,104,144,255))
	        draw.RoundedBox(0, 0, 0, w, h, Color(47,104,144,255))
	    end

	    local Lips_Atm_BtnClose1 = vgui.Create( "DButton", Lips_Atm_MenuRetirer ) 
	    Lips_Atm_BtnClose1:SetText( Lips_Atm_Config.Close )
	    Lips_Atm_BtnClose1:SetTextColor(Color(255,255,255))
	    Lips_Atm_BtnClose1:SetFont("Lips_Atm_Font3")
	    Lips_Atm_BtnClose1:SetSize( scw * 220, sch * 25 )
	    Lips_Atm_BtnClose1:SetPos( scw * 5, sch * 87 ) 

	    Lips_Atm_BtnClose1.DoClick = function()

	    	Lips_Atm_MenuRetirer:Close()

		end

	    Lips_Atm_BtnClose1.Paint = function(self, w, h)
	        DrawBlur(self, 2)
	        draw.RoundedBox(0, 0, 0, w, h, Color(47,104,144,255))
	        draw.RoundedBox(0, 0, 0, w, h, Color(47,104,144,255))
	    end

	end

end)