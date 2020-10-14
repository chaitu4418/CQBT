-- This is common code having some Utility classes for manipulating Data etc


require('__shared/util/sectorData')
g_sectorTable = loadSectorTable()
--print(g_sectorTable)

function changeSectorPoints(text,instance)
    print('Adding :' .. text .. ' !!!')
    instance = VolumeVectorShapeData(instance)
    instance:MakeWritable()
    instance.points:clear()

    for _,point in pairs(g_sectorTable[text]) do
        instance.points:add(point)
    end
end

function getSectorData(text)
    return g_sectorTable[text]
end