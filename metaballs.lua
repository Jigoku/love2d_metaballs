--[[
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 * u should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 --]]

--  Ported to Lua/Love2d by unixfreak (ricky thomson)
--  based on project from here:
--  https://www.youtube.com/watch?v=ccYLb7cLB1I

metaballs = {}

-- surface dimensions
-- this is the size of the image provided by metaballs.surface()
-- making this too high will severly drop frame rate
metaballs.w = 160
metaballs.h = 120

metaballs.balls = {}
metaballs.imageData = love.image.newImageData(metaballs.w, metaballs.h)


-- add metaballs
function metaballs.create(num)
	for i=1, num do
		table.insert(metaballs.balls, {
			x = love.math.random(0,metaballs.w),
			y = love.math.random(0,metaballs.h),
			vx = love.math.random(10,500)/10,
			vy = love.math.random(10,500)/10,
			r = love.math.random(500,6000)
		})
	end
end

-- create a drawable image surface of the metaballs
function metaballs.surface()
	if #metaballs.balls < 0 then return end
	
	-- set pixel values
	for x=0, metaballs.w-1 do
		for y=0, metaballs.h-1 do
			local index = x + y * metaballs.w;
			local sum = 0
			for _,b in ipairs(metaballs.balls) do
				local d = dist(x, y, b.x, b.y);
				sum = sum + 100 * b.r / d;
			end
			-- pos / color
			metaballs.imageData:setPixel(x,y,HSL(sum/255/255,0.5,sum/255/255,1))
		end
	end

	return love.graphics.newImage(metaballs.imageData)
	
end


function metaballs.update(dt)
	if #metaballs.balls < 0 then return end
	
	for _,b in ipairs(metaballs.balls) do
		-- bounce on the edges of the screen
		b.x = math.max(0,math.min(metaballs.w, b.x + b.vx *dt))
		b.y = math.max(0,math.min(metaballs.h, b.y + b.vy *dt))
		if (b.x >= metaballs.w or b.x <= 0) then b.vx = b.vx * -1 end
		if (b.y >= metaballs.h or b.y <= 0) then b.vy = b.vy * -1 end
	end
end

-- calculate distance between two points
function dist(x1,y1,x2,y2) return math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2) end


-- From https://love2d.org/wiki/HSL_color
-- Modified to use floating point numbers for love2d 11.x
function HSL(h, s, l, a)
	if s<=0 then return l,l,l,a end
	h, s, l = h*6, s, l
	local c = (1-math.abs(2*l-1))*s
	local x = (1-math.abs(h%2-1))*c
	local m,r,g,b = (l-.5*c), 0,0,0
	if h < 1     then r,g,b = c,x,0
	elseif h < 2 then r,g,b = x,c,0
	elseif h < 3 then r,g,b = 0,c,x
	elseif h < 4 then r,g,b = 0,x,c
	elseif h < 5 then r,g,b = x,0,c
	else              r,g,b = c,0,x
	end return (r+m),(g+m),(b+m),a
end

