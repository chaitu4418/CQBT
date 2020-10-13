require('__shared/util/common')

local usAttSec1 = 'US_Attack_Sector_1_Map_Points'


local tdmLogicPartitionGuid = Guid('9D089A81-9D75-4759-AF58-D2F91C1D095A')
local tdmMapAreaGuid = Guid('E9B86E95-2090-4C6B-97D5-98DEA5544847')

local usSector1VectorData = ResourceManager:RegisterInstanceLoadHandler(tdmLogicPartitionGuid, tdmMapAreaGuid, function(instance)
    changeSectorPoints(usAttSec1, instance)
end)
