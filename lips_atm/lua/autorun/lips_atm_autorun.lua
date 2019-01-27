if (SERVER) then

	local plyMeta = FindMetaTable("Player")

	function plyMeta:UpdateATMToFile()

		if ( not IsValid( self ) ) then return end

		if ( not file.Exists( "lips_atm_data", "DATA" ) ) then

			file.CreateDir("lips_atm_data")

		end

		local PlyMoney = self:GetNWInt( "lips_atm_balance", 0 )

		file.Write( "lips_atm_data/" .. self:SteamID64() .. ".txt", PlyMoney )

	end

	hook.Add( "PlayerInitialSpawn", "CustomATM_PlayerInitialSpawn_Hook", function( ply )

		if ( not IsValid( ply ) ) then return end

		if ( not file.Exists( "lips_atm_data", "DATA" ) ) then

			file.CreateDir("lips_atm_data")

		end

		if( file.Exists( "lips_atm_data/" .. ply:SteamID64() .. ".txt", "DATA" ) ) then

			local PlyMoney = tonumber( file.Read( "lips_atm_data/" .. ply:SteamID64() .. ".txt", "DATA" ) )

			if( PlyMoney ) then

				ply:SetNWInt( "lips_atm_balance", PlyMoney )

			end

		end

	end)

end