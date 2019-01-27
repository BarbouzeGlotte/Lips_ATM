AddCSLuaFile( "cl_init.lua" ) -- Make sure clientside
AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent.
 
include('shared.lua')
 
function ENT:Initialize()
 
	self:SetModel( Lips_Atm_Config.ModelProps )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
 
    local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end

end

function ENT:SpawnFunction( ply, tr, ClassName )

	if ( !tr.Hit ) then return end

	local SpawnPos = tr.HitPos + tr.HitNormal * 10
	local SpawnAng = ply:EyeAngles()
	SpawnAng.p = 0
	SpawnAng.y = SpawnAng.y + 180

	local ent = ents.Create( ClassName )
	ent:SetPos( SpawnPos + Vector(0,0,25) )
	ent:SetAngles( SpawnAng )
	ent:Spawn()
	ent:Activate()

	return ent

end
 
util.AddNetworkString("lips_atm_openmenu")

util.AddNetworkString("lips_atm_deposit")

util.AddNetworkString("lips_atm_retirer")

function ENT:Use( activator, caller )

	if caller.time == nil then
		caller.time = 0
	end

	if CurTime() < caller.time then
		return false
	end

	if IsValid(caller) then

		if caller:IsPlayer() then

			if caller:GetPos():DistToSqr(self:GetPos()) > 200 then

				net.Start("lips_atm_openmenu")

				net.Send(caller)

				caller.time = CurTime() + 1

			end

		end
		
	end

    return
end

net.Receive("lips_atm_deposit", function(len, ply)

	local DepositMoney = net.ReadInt(32)

	if (not IsValid( ply ) ) then return end

	if not ( DepositMoney ) then return end

	if( isnumber( DepositMoney ) ) then 

		if( DepositMoney > 0 ) then

			if( ply:getDarkRPVar( "money" ) >= DepositMoney ) then

				ply:addMoney( -DepositMoney )

				ply:SetNWInt( "lips_atm_balance", ply:GetNWInt( "lips_atm_balance", 0 ) + DepositMoney )

				DarkRP.notify( ply, 0, 3, Lips_Atm_Config.Deposit.." "..DarkRP.formatMoney( DepositMoney )..".")

				ply:UpdateATMToFile()

			else

				DarkRP.notify( ply, 1, 3, Lips_Atm_Config.DError1 )

			end

		else

			DarkRP.notify( ply, 1, 3, Lips_Atm_Config.DError2 )

		end

	else

		DarkRP.notify( ply, 1, 3, Lips_Atm_Config.DError3 )

	end

end)
 
net.Receive("lips_atm_retirer", function(len, ply)

	local WithdrawMoney = net.ReadInt(32)

	if (not IsValid( ply ) ) then return end

	if not ( WithdrawMoney ) then return end

	if( isnumber( WithdrawMoney ) ) then 

		if( WithdrawMoney > 0 ) then

			if( ply:GetNWInt( "lips_atm_balance", 0 ) >= WithdrawMoney ) then

				ply:SetNWInt( "lips_atm_balance", ply:GetNWInt( "lips_atm_balance", 0 ) - WithdrawMoney )

				ply:addMoney( WithdrawMoney )

				DarkRP.notify( ply, 0, 3,  Lips_Atm_Config.Withdraw.." "..DarkRP.formatMoney( WithdrawMoney ) .. "." )

				ply:UpdateATMToFile()

			else

				DarkRP.notify( ply, 1, 3, Lips_Atm_Config.WError1 )

			end

		else

			DarkRP.notify( ply, 1, 3, Lips_Atm_Config.WError2 )

		end

	else

		DarkRP.notify( ply, 1, 3, Lips_Atm_Config.WError3 )

	end

end)
