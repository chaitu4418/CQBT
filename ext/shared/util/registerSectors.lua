require('__shared/util/common')

-- Remove redzones from minimap

local tdmUIRedZonePartitionGuid = Guid('8C81DDE2-D9AC-11E1-BE2C-88FA6D56EB45')
local tdmUIRedZoneMapArea = Guid('D86A9367-3E30-7E3D-8C05-10CEAB2CFD52')

ResourceManager:RegisterInstanceLoadHandler(tdmUIRedZonePartitionGuid, tdmUIRedZoneMapArea, function(instance)
        local caAsset = VeniceUICombatAreaAsset(instance)
        caAsset:MakeWritable()
        caAsset.distanceField = nil
        caAsset.surroundingDistanceField = nil
end)

local usAttDefSec1 = 'US_Attack_Defend_Sector_1_Map_Points'
local usAttDefSec2 = 'US_Attack_Defend_Sector_2_Map_Points'
local usAttDefSec3 = 'US_Attack_Defend_Sector_3_Map_Points'
local ruAttDefSec1 = 'RU_Attack_Defend_Sector_1_Map_Points'
local ruAttDefSec2 = 'RU_Attack_Defend_Sector_2_Map_Points'
local ruAttDefSec3 = 'RU_Attack_Defend_Sector_3_Map_Points'


local tdmLogicPartitionGuid = Guid('9D089A81-9D75-4759-AF58-D2F91C1D095A')
local tdmMapAreaGuid = Guid('E9B86E95-2090-4C6B-97D5-98DEA5544847')

local usSector1VectorData = ResourceManager:RegisterInstanceLoadHandler(tdmLogicPartitionGuid, tdmMapAreaGuid, function(instance)
    changeSectorPoints(usAttDefSec1, instance)
end)
