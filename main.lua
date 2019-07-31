function love.load()
	love.window.setMode(800, 600)
	require("metaballs") 
	metaballs.create(8)
end

function love.draw()
	-- draw the metaball surface
	love.graphics.setColor(1,1,1,1)
	love.graphics.draw(metaballs.surface(),0,0,0,love.graphics.getWidth()/metaballs.w,love.graphics.getHeight()/metaballs.h)
	
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
