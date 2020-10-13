-- This is temporary and will be removed
-- This is just the draw the UI vector data to get a idea
-- This is taken from Janssent mapzone helper mod

class 'XP4FD_DrawSectorHud'

function XP4FD_CQBTServer:drawUIHud(text)

    print('Drawing ' .. text)
    local vertices = {}

    for i, point in pairs(sectorTable[text]) do

        -- Draw green spheres for the first point
        if i == 1 then

            DebugRenderer:DrawSphere(point, 0.1, Vec4(0, 1, 0, 0.5), true, false)
            DebugRenderer:DrawSphere(point+up, 0.1, Vec4(0, 1, 0, 0.5), true, false)
        else
            -- Draw segment between saved points
            AppendVerticesForSegment(vertices, points[i-1], points[i])

            -- Draw 2 green spheres at every point that isn't the active one
            if i ~= activeIndex then
                DebugRenderer:DrawSphere(point, 0.1, Vec4(1, 1, 1, 0.5), true, false)
                DebugRenderer:DrawSphere(point+up, 0.1, Vec4(1, 1, 1, 0.5), true, false)
            end
        end
    end

    -- Draw the segment between the last and the first point
    if #points > 0 and closeLoop then

        self:AppendVerticesForSegment(vertices, points[#points], points[1])
    end

    -- Draw 2 red spheres on the active point
    if activeIndex then

        DebugRenderer:DrawSphere(points[activeIndex], 0.1, Vec4(1, 0, 0, 0.5), true, false)
        DebugRenderer:DrawSphere(points[activeIndex]+up, 0.1, Vec4(1, 0, 0, 0.5), true, false)

        -- Draw 2 blue spheres on the selected point
    elseif selectedIndex then

        DebugRenderer:DrawSphere(points[selectedIndex], 0.1, Vec4(0, 0, 1, 0.5), true, false)
        DebugRenderer:DrawSphere(points[selectedIndex]+up, 0.1, Vec4(0, 0, 1, 0.5), true, false)
    end

    DebugRenderer:DrawVertices(0, vertices)


end

function XP4FD_CQBTServer:AppendVerticesForSegment(vertices, from, to)

    local i = #vertices

    -- Every segment is 2 triangles, each triangle is 3 points
    vertices[i+1] = self:GetVertexForPoint(from)	-- ◩
    vertices[i+2] = self:GetVertexForPoint(from+up)
    vertices[i+3] = self:GetVertexForPoint(to+up)

    vertices[i+4] = self:GetVertexForPoint(from) -- ◪
    vertices[i+5] = self:GetVertexForPoint(to)
    vertices[i+6] = self:GetVertexForPoint(to+up)
end

function XP4FD_CQBTServer:GetVertexForPoint(vec3)

    local vertex = DebugVertex()
    vertex.pos = vec3
    vertex.color = Vec4(1, 1, 1, 0.5)

    return vertex
end

g_XP4FD_DrawSectorHud = XP4FD_DrawSectorHud()