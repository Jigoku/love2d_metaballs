-- example program using metaballs.lua module

function love.load()
	love.window.setMode(1024, 768)
	require("metaballs") 
	metaballs.create(8)
end

function love.draw()
	-- draw the metaball surface
	love.graphics.setColor(1,1,1,1)
	
	local w = love.graphics.getWidth()
	local h = love.graphics.getHeight()
	
	-- draw metaballs, stretch/scale to window size
	love.graphics.draw(metaballs.surface(),w/2,h/2,0,w/metaballs.w,h/metaballs.h, metaballs.w/2,metaballs.h/2, 0,0)
	
	-- fps display
	love.graphics.setColor(0,0,0,0.6)
	love.graphics.rectangle("fill", 5,5, 60,25)
	love.graphics.setColor(0,1,0,1)
	love.graphics.print("fps: ".. love.timer.getFPS(),10,10)
end

function love.update(dt)
	metaballs.update(dt)
end

function love.keypressed(key)
	if key == "escape" then love.event.quit() end
end
