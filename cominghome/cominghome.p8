pico-8 cartridge // http://www.pico-8.com
version 34
__lua__
function _init()
	last = time()
	fade_timer = 0
	resetting = false
	
	shooting_star = {}
	reset_shooting_star(shooting_star)
	explosion = nil

	map_setup()
	//music(0)
	
	levels={}
	levels[1]=level_1()
	levels[2]=level_2()
	levels[3]=level_3()
	levels[4]=level_4()
	levels[5]=level_5()
	levels[6]=level_6()
	levels[7]=level_7()
	levels[8]=level_8()
	levels[9]=level_9()
	
	planets={}
	asteroids={}
	
	level_index = 0
	
	stars={}
	for i=1,50 do
		stars[i]=make_star()
	end
	
	next_level()
	make_ship()
end

function _update()
	delta = time() - last
	move_ship()
	update_fade()
	update_shooting_star(shooting_star,delta)
	
	if (explosion != nil) then
		if (update_particle_explosion(explosion,delta)) then
			explosion = nil
		end
	end
	
	last = time()
end

function _draw()
	cls()
	draw_map()

	for key,value in pairs(stars) do
		draw_star(value)
	end
	
	draw_shooting_star(shooting_star)
	
	draw_ship()
	
	for key,value in pairs(planets) do
		draw_planet(value)
	end
	
	for key,value in pairs(asteroids) do
		draw_asteroid(value)
	end
	
	if (explosion != nil) then
		draw_particle_explosion(explosion)
	end
	
	draw_fuel()
	draw_fade()
end

function draw_fuel()
	rectfill(127/2-8,127-4,127/2+8,127,7)
	rectfill(127/2-7,127-3,127/2-7+14*s.fuel,127-1,8)
end

function draw_fade()
	if (fade_timer <= 0) then
		return
	end
	width = 127 - (127 * abs(0.5 - fade_timer) * 2)
	if (fade_timer > 0.5) then
		for x=0,width do
			for y=0,127 do
				pset(x,y,0)
			end
		end
	else
		for x=127-width,127 do
			for y=0,127 do
				pset(x,y,0)
			end
		end
	end
end

function update_fade()
	if (fade_timer > 0) then
		fade_timer -= delta
		if (fade_timer < 0.5 and not resetting) then
			resetting = true
			if (s.planet == -1) then
				reset_ship()
			else
				next_level()
				reset_ship()
			end
		end
	else
		fade_timer = 0
		resetting = false
	end
end

function next_level()
	level_index += 1
	if (level_index > count(levels)) then
		return
	end
	planets=levels[level_index].planets
	asteroids=levels[level_index].asteroids
end
-->8
function map_setup()
end

function draw_map()
	map(0, 0, 0, 0, 16, 16)
end

function level_1()
	planets={}
	planets[1]=make_planet(13,8,1)
	planets[2]=make_planet(4,8,2)
	
	asteroids={}
	
	level={}
	level.planets = planets
	level.asteroids = asteroids
	return level
end

function level_2()
	planets={}
	planets[1]=make_planet(13,8,1)
	planets[2]=make_planet(4,8,2)
	
	asteroids={}
	asteroids[1]=make_asteroid(9,7)
	asteroids[2]=make_asteroid(9,8)
	asteroids[3]=make_asteroid(9,9)
	
	level={}
	level.planets = planets
	level.asteroids = asteroids
	return level
end

function level_3()
	planets={}
	planets[1]=make_planet(13,8,1)
	planets[2]=make_planet(4,8,2)
	
	asteroids={}
	asteroids[1]=make_asteroid(7,6,true)
	asteroids[2]=make_asteroid(7,7,true)
	asteroids[3]=make_asteroid(7,8,true)
	asteroids[4]=make_asteroid(7,9,true)
	
	level={}
	level.planets = planets
	level.asteroids = asteroids
	return level
end

function level_4()
	planets={}
	planets[1]=make_planet(13,13,1)
	planets[2]=make_planet(6,8,2)
	planets[3]=make_planet(5,13,3)
	
	asteroids={}
	asteroids[1]=make_asteroid(9,9)
	asteroids[2]=make_asteroid(9,10)
	asteroids[3]=make_asteroid(9,11)
	asteroids[4]=make_asteroid(9,12)
	asteroids[5]=make_asteroid(9,13)
	asteroids[6]=make_asteroid(9,14)
	asteroids[7]=make_asteroid(9,15)
	
	level={}
	level.planets = planets
	level.asteroids = asteroids
	return level
end

function level_5()
	planets={}
	planets[1]=make_planet(13,10,1)
	planets[2]=make_planet(4,4,2)
	planets[3]=make_planet(4,9,3)

	asteroids={}
	asteroids[1]=make_asteroid(9,11)
	asteroids[2]=make_asteroid(10,10)
	asteroids[3]=make_asteroid(11,9)
	asteroids[4]=make_asteroid(12,8)
	asteroids[5]=make_asteroid(13,7)
	asteroids[6]=make_asteroid(14,6)
	
	level={}
	level.planets = planets
	level.asteroids = asteroids
	return level
end

function level_6()
	planets={}
	planets[1]=make_planet(14,5,1)
	planets[2]=make_planet(3,3,2)
	planets[3]=make_planet(8,14,3)
	
	asteroids={}
	asteroids[1]=make_asteroid(10,1)
	asteroids[2]=make_asteroid(9,2)
	asteroids[3]=make_asteroid(8,3)
	asteroids[4]=make_asteroid(7,4)
	asteroids[5]=make_asteroid(9,7)
	asteroids[6]=make_asteroid(10,8)
	asteroids[7]=make_asteroid(11,9)
	asteroids[8]=make_asteroid(12,10)
	asteroids[9]=make_asteroid(13,11)
	
	level={}
	level.planets = planets
	level.asteroids = asteroids
	return level
end

function level_7()
	planets={}
	planets[1]=make_planet(10,2,1)
	planets[2]=make_planet(9,14,2)
	planets[3]=make_planet(14,8,3)
	planets[4]=make_planet(3,8,4)
	
	asteroids={}
	asteroids[1]=make_asteroid(6,2)
	asteroids[3]=make_asteroid(7,3)
	asteroids[4]=make_asteroid(8,4)
	asteroids[5]=make_asteroid(9,5)
	asteroids[6]=make_asteroid(10,5)
	asteroids[7]=make_asteroid(11,5)
	asteroids[8]=make_asteroid(1,11)
	asteroids[9]=make_asteroid(2,11)
	asteroids[10]=make_asteroid(3,11)
	asteroids[11]=make_asteroid(4,11)
	asteroids[12]=make_asteroid(5,11)
	asteroids[13]=make_asteroid(6,11)
	asteroids[14]=make_asteroid(7,11)
	asteroids[15]=make_asteroid(8,11)
	asteroids[16]=make_asteroid(9,10)
	asteroids[17]=make_asteroid(10,9)
	asteroids[18]=make_asteroid(11,8)
	asteroids[19]=make_asteroid(12,8)
	
	level={}
	level.planets = planets
	level.asteroids = asteroids
	return level
end

function level_8()
	planets={}
	planets[1]=make_planet(8,3,1)
	planets[2]=make_planet(8,14,2)
	
	asteroids={}
	asteroids[1]=make_asteroid(7,10)
	asteroids[2]=make_asteroid(8,10)
	asteroids[3]=make_asteroid(9,10)
	
	asteroids[4]=make_asteroid(5,6,true)
	asteroids[5]=make_asteroid(6,6,true)
	asteroids[6]=make_asteroid(7,6,true)
	asteroids[7]=make_asteroid(9,6,true)
	asteroids[8]=make_asteroid(10,6,true)
	asteroids[9]=make_asteroid(11,6,true)
	
	level={}
	level.planets = planets
	level.asteroids = asteroids
	return level
end

function level_9()
	planets={}
	planets[1]=make_planet(4,4,1)
	planets[2]=make_planet(14,13,2)
	planets[3]=make_planet(13,5,3)
	planets[4]=make_planet(4,13,4)
	
	asteroids={}
	asteroids[1]=make_asteroid(3,7)
	asteroids[2]=make_asteroid(4,7)
	asteroids[3]=make_asteroid(10,5)
	asteroids[4]=make_asteroid(5,8)
	asteroids[5]=make_asteroid(5,9)
	asteroids[6]=make_asteroid(4,10)
	asteroids[7]=make_asteroid(10,6)
	asteroids[8]=make_asteroid(10,7)
	asteroids[9]=make_asteroid(11,12)
	asteroids[10]=make_asteroid(11,13)
	asteroids[11]=make_asteroid(11,14)
	asteroids[12]=make_asteroid(10,4)
	asteroids[13]=make_asteroid(11,3)
	
	asteroids[14]=make_asteroid(7,7,true)
	asteroids[15]=make_asteroid(8,7,true)
	
	asteroids[16]=make_asteroid(2,7)
	asteroids[17]=make_asteroid(1,8)
	asteroids[18]=make_asteroid(1,9)
	asteroids[19]=make_asteroid(2,10)
	asteroids[20]=make_asteroid(3,10)
	
	level={}
	level.planets = planets
	level.asteroids = asteroids
	return level
end

function level_22()
	planets={}
	planets[1]=make_planet(10,3,1)
	planets[2]=make_planet(3,3,2)
	planets[3]=make_planet(5,13,3)
	planets[4]=make_planet(12,12,4)
	
	asteroids={}
	asteroids[1]=make_asteroid(8,8)
	asteroids[2]=make_asteroid(7,7)
	asteroids[3]=make_asteroid(9,9)
	asteroids[4]=make_asteroid(10,8)
	asteroids[5]=make_asteroid(11,7)

	level={}
	level.planets = planets
	level.asteroids = asteroids
	return level
end

function level_32()
	planets={}
	planets[1]=make_planet(13,15,1)
	planets[2]=make_planet(3,13,2)
	planets[3]=make_planet(13,6,3)
	planets[4]=make_planet(4,4,4)
	
	asteroids={}
	asteroids[1]=make_asteroid(9,2)
	asteroids[2]=make_asteroid(9,7)
	asteroids[3]=make_asteroid(6,8)
	asteroids[4]=make_asteroid(7,8)
	asteroids[5]=make_asteroid(3,10)
	asteroids[6]=make_asteroid(4,10)
	asteroids[7]=make_asteroid(12,12)
	asteroids[8]=make_asteroid(13,12)
	asteroids[9]=make_asteroid(14,12)

	level={}
	level.planets = planets
	level.asteroids = asteroids
	return level
end

function level_42()
	planets={}
	planets[1]=make_planet(13,8,1)
	planets[2]=make_planet(3,8,2)
	
	asteroids={}
	asteroids[1]=make_asteroid(9,7,true)
	asteroids[2]=make_asteroid(9,8,true)
	asteroids[3]=make_asteroid(9,9,true)

	level={}
	level.planets = planets
	level.asteroids = asteroids
	return level
end
-->8
function make_ship()
	s={}
	reset_ship()
end

function acos(x)
	return (-0.69813170079773212 * x * x - 0.87266462599716477) * x + 1.5707963267948966;
end

function distance(x1,y1,x2,y2)
	x=abs(x1-x2)
	y=abs(y1-y2)
	return sqrt(x*x+y*y)
end

function planet_collision()
	for key,value in pairs(planets) do
		dist = distance(value.x,value.y,s.x,s.y)
		if (dist < value.orbit_radius) then
			return key
		end
	end
	return -1
end

function asteroid_collision()
	for key,value in pairs(asteroids) do
		if (not value.broken) then
			shot_1_dist = distance(value.x,value.y,s.shots[1].x,s.shots[1].y)
			shot_2_dist = distance(value.x,value.y,s.shots[2].x,s.shots[2].y)
			if (shot_1_dist < 0.7 or shot_2_dist < 0.7) then
				if (value.breakable and s.shots[2].x != 0) then
					value.broken = true
					explosion = make_particle_explosion(value.x,value.y,50)
				else
					if (shot_1_dist < 0.7) then
						s.shots[1].x = 64
						s.shots[1].y = 64
					else
						s.shots[2].x = 64
						s.shots[2].y = 64
					end
				end
			end
			
			dist = distance(value.x,value.y,s.x,s.y)
			if (dist < 1) then
				return key
			end
		end
	end
	return -1
end

function reset_ship()
	s.x=planets[count(planets)].x + 1
 s.y=planets[count(planets)].y + 1
	s.sprite=5
	s.angle=1
	s.speed=0.2
	s.planet=-1
	s.fuel=1
	s.thrust_direction=0
 s.cooldown=0
 s.death_timer=0
 s.direction=1
 s.last_x=s.x
 s.last_y=s.y
 s.shots={}
 s.shots[1]={x=64,y=64,angle=1,speed=0.75}
 s.shots[2]={x=64,y=64,angle=1,speed=0.75}
	for key,value in pairs(asteroids) do
		value.broken = false
	end
end

function calc_angle(direction)
	planet_angle = atan2(s.y - planets[s.planet].y, s.x - planets[s.planet].x)
 length = s.speed
 v = acos(length / (2 * planets[s.planet].orbit_radius)) / 6.28328530718
	return normalize_angle(planet_angle + (0.25 - v * s.direction * 1.08))
end

function normalize_angle(angle)
	if (angle >= 1) angle -= 1
	if (angle < 0) angle += 1
	return angle
end

function move_ship()
	if (s.death_timer > 0) then
		s.death_timer -= delta
		return
	else
		s.death_timer = 0
	end

	if s.planet == -1 and s.cooldown <= 0 then
		index = planet_collision()
		s.planet = index
		if s.planet > -1 then
			org_planet_angle = atan2(s.last_y - planets[s.planet].y,s.last_x - planets[s.planet].x)
			cur_planet_angle = atan2(s.y - planets[s.planet].y,s.x - planets[s.planet].x)
			if (abs(org_planet_angle - cur_planet_angle) > 0.5) then
				max_angle = max(org_planet_angle,cur_planet_angle)
				org_planet_angle = normalize_angle(org_planet_angle - max_angle)
				cur_planet_angle = normalize_angle(cur_planet_angle - max_angle)
			end
			s.direction = org_planet_angle > cur_planet_angle and 1 or -1
		end
		if s.planet == 1 then
			fade_timer = 1
		end
	end
	
	if (s.planet > -1) then
		s.angle = calc_angle(s.direction)
	end

 if (s.cooldown > 0) then
  s.cooldown -= delta
 end
	
 if (btnp(4) and s.cooldown <= 0) then 
  s.planet = -1
  s.last_x = s.x
  s.last_y = s.y
  s.cooldown = 0.5
 end
 
 s.thrust_direction=0
 if (s.planet == -1) then
 	if (s.fuel > 0) then
 		if (btn(0)) then
 			s.angle -= 0.005
 			s.fuel -= 0.03
 			s.thrust_direction=1
	 	end
 		if (btn(1)) then
 			s.angle += 0.005
 			s.fuel -= 0.03
 			s.thrust_direction=-1
 		end
 	else
 		s.fuel = 0
 	end
 end
 
 s.angle = normalize_angle(s.angle)
 
 if (btnp(5) and s.shots[1].x == 64 and s.shots[2].x == 64) then
 	s.shots[1].x = s.x
 	s.shots[1].y = s.y
 	s.shots[1].angle = s.angle + 0.05
 	s.shots[2].x = s.x
 	s.shots[2].y = s.y
 	s.shots[2].angle = s.angle - 0.05
 end
 
 update_shot(s.shots[1])
 update_shot(s.shots[2])
	
	s.x = s.x + s.speed * cos(s.angle)
	s.y = s.y - s.speed * sin(s.angle)

	if (fade_timer == 0 and (s.x < -2 or s.x > 18 or s.y < -2 or s.y > 18)) then
		fade_timer = 1
	end
	
	asteroid_index = asteroid_collision()
	if (explosion == nil and (asteroid_index > -1)) then
		s.death_timer = 0.7
		explosion = make_particle_explosion(s.x,s.y,50)
		s.x = 64
	end
end

function update_shot(s)
	if (s.x != 64) then
 	s.x = s.x + s.speed * cos(s.angle)
 	s.y = s.y - s.speed * sin(s.angle)
 	if (s.x > 16 or s.x < 0 or s.y < 0 or s.y > 16) then
 		s.x = 64
 		s.y = 64
 	end
 end
end

function draw_ship()
	if (s.thrust_direction != 0) then
		a = s.angle + 0.45 * s.thrust_direction
		x2 = s.x + cos(a) * 0.6
		y2 = s.y - sin(a) * 0.6
		line(s.x*8,s.y*8,x2*8,y2*8,9)
	end
	
 s.sprite = 18 + flr(8 * s.angle)
	spr(s.sprite,(s.x*8) - 2,(s.y*8) - 2,0.5,0.5)
	
	draw_shot(s.shots[1])
	draw_shot(s.shots[2])
end

function draw_shot(shot)
	x2 = shot.x + cos(shot.angle)
	y2 = shot.y - sin(shot.angle)
	line(shot.x*8,shot.y*8,x2*8,y2*8,8)
end






-->8
function make_planet(x,y,sprite)
	p={}
	p.x=x
	p.y=y
	p.sprite=sprite
	p.orbit_radius=2
	return p
end

function draw_planet(p)
	spr(p.sprite,p.x*8 - 4,p.y*8 - 4)
end

function make_asteroid(x,y,breakable)
	a={}
	a.x=x
	a.y=y
	a.width=1
	a.height=1
	a.breakable=breakable
	a.broken=false
	a.sprite=a.breakable and 27 or 26
	return a
end

function draw_asteroid(a)
	if (not a.broken) then
		spr(a.sprite,a.x*8-4,a.y*8-4)
	end
end

function make_star()
	s={}
	s.timer=0
	s.x=rnd(128)
	s.y=rnd(128)
	return s
end

function draw_star(s)
	if (s.timer > 0) then
		s.timer -= delta
	else
		activate = ceil(rnd(200)) == 5
		if (activate) then
			s.timer = 2
		else
			s.timer = 0
		end
	end
	
	brightness = abs(2 - (ceil(2 * s.timer + 1) - 1))
	c = 7 - brightness
	pset(s.x,s.y,c)
end
-->8
function make_particle_explosion(x,y,size)
	particles = {}
	for i=1,size do
		p = {}
		p.angle = rnd(1)
		p.speed = rnd(0.4)
		p.lifetime = 0.7
		p.timer = 0
		p.x = x
		p.y = y
		particles[i] = p
	end
	return particles
end

function update_particle_explosion(particles,delta)
	for key,value in pairs(particles) do
		value.timer += delta
		if (value.timer > value.lifetime) then
			return true
		end
		value.x += value.speed * cos(value.angle)
		value.y -= value.speed * sin(value.angle)
	end
	return false
end

function draw_particle_explosion(particles)
	for key,value in pairs(particles) do
		c = 7 - flr((value.timer / value.lifetime) * 3)
		if (c > 4) then
			pset(value.x*8,value.y*8,c)
		end
	end
end

function reset_shooting_star(s)
	s.timer=0
	s.angle=rnd(1)
	s.x=rnd(60) + 30
	s.y=rnd(60) + 30
	s.lifetime=0.4
	s.next=rnd(2)+1
end

function update_shooting_star(s,delta)
	if (s.next > 0 and s.timer == 0) then
		s.next -= delta
	elseif (s.next <= 0) then
		s.timer += delta
		s.next = 0
	end
	
	if (s.timer > s.lifetime) then
		reset_shooting_star(s)
	end
end

function draw_shooting_star(s)
	if (s.timer == 0) then
		return
	end
	
	brightness = abs(2 - (ceil(5 * (s.timer / s.lifetime)) - 1))
	c = 7 - brightness
	
	x1 = s.x + cos(s.angle) * s.timer * 100
	y1 = s.y + sin(s.angle) * s.timer * 100
	x2 = x1 + cos(s.angle) * 10
	y2 = y1 + sin(s.angle) * 10
	line(x1,y1,x2,y2,c)
end
__gfx__
0000000000cccc00005554000000000000dddd007770000000007700770000770077000000000777770000000007700000000077000000000000000000000000
000000000cccc3300554444000ffff66066666607777000000007700777777770077000000007777777700000007700000007777000000000000000000000000
00700700ccccc333554444440f77ff66dddddd6d0777700000077700777777770077700000077770077777770007700077777770000000000000000000000000
000770003333cccc4445444407fff66066666dd60777777700777700077777700077770077777770077777770077770077777770000000000000000000000000
000770003333cccc445554446ff66670dddd6ddd0777777777777770007777000777777777777770007777000777777000777700000000000000000000000000
007007003333c3334444445566667ff0666dd6dd0777700077777770000770000777777700077770007770007777777700077700000000000000000000000000
000000000333c3300455445066ffff000d6ddd607777000000007777000770007777000000007777007700007777777700007700000000000000000000000000
0000000000ccc300004444000000000000d6dd007770000000000077000770007700000000000777007700007700007700007700000000000000000000000000
77000070007777007700000000700000700700000700000000770000770000000770000000770000000000d00045004000000000000000000000000000000000
077707707770777707770000077000007777000007700000777000007777000007700000777700000dd00d5d0000000000000000000000000000000000000000
07777777777007700777000077770000077000007777000077700000077000007777000007700000d55505d50400544000000000000000000000000000000000
770000770077070077000000007700000770000077000000007700000700000070070000007000000d5000d05400440000000000000000000000000000000000
70070700077000770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
777707700770777700000000000000000000000000000000000000000000000000000000000000000dd555000540045000000000000000000000000000000000
07707777777707700000000000000000000000000000000000000000000000000000000000000000dd55d5500540000000000000000000000000000000000000
07707700700700700000000000000000000000000000000000000000000000000000000000000000055d55000000040000000000000000000000000000000000
__label__
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
88888eeeeee888eeeeee888777777888eeeeee888eeeeee888888888888888888888888888888888888ff8ff8888228822888222822888888822888888228888
8888ee888ee88ee88eee88778887788ee888ee88ee8e8ee88888888888888888888888888888888888ff888ff888222222888222822888882282888888222888
888eee8e8ee8eeee8eee8777778778eeeee8ee8eee8e8ee88888e88888888888888888888888888888ff888ff888282282888222888888228882888888288888
888eee8e8ee8eeee8eee8777888778eeee88ee8eee888ee8888eee8888888888888888888888888888ff888ff888222222888888222888228882888822288888
888eee8e8ee8eeee8eee8777877778eeeee8ee8eeeee8ee88888e88888888888888888888888888888ff888ff888822228888228222888882282888222288888
888eee888ee8eee888ee8777888778eee888ee8eeeee8ee888888888888888888888888888888888888ff8ff8888828828888228222888888822888222888888
888eeeeeeee8eeeeeeee8777777778eeeeeeee8eeeeeeee888888888888888888888888888888888888888888888888888888888888888888888888888888888
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
16661666166111711166111116161111111111111666161116661661166616661166177111661111166616111666166116661666117711111616111111661111
11611616161617111611111116161111111111111616161116161616161111611611171116111111161616111616161616111161111711111616111116111111
11611666161617111666111116661111177711111666161116661616166111611666171116661111166616111666161616611161111711111666111116661111
11611616161617111116111111161111111111111611161116161616161111611116171111161111161116111616161616111161111711111116111111161111
11611616161611711661117116661111111111111611166616161616166611611661177116611171161116661616161616661161117711711666111116611171
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
111116661611166616611666166611771111116616661666166616661111166616661661166616161166117111711111111711111c1111111ccc1ccc1ccc1ccc
111116161611161616161611116111171111161616161616116111611111161616161616116116161611111711171111117111111c111111111c1c1c111c111c
111116661611166616161661116111171111161616611661116111611111166116661616116116161666111711171111117111111ccc11111ccc1ccc11cc1ccc
111116111611161616161611116111171111161616161616116111611111161616161616116116161116111711171111117111111c1c11111c111c1c111c1c11
117116111666161616161666116111771171166116161666166611611666161616161666166611661661117111711111171111111ccc11c11ccc1ccc1ccc1ccc
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
111111111cc111111ccc1cc111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1111111111c111111c1c11c111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111ccc11c111111c1c11c111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1111111111c111111c1c11c111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
111111111ccc11c11ccc1ccc11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11661611166611111111111116161111171711111666161116661661166616661166177111661111166616111666166116661666117711111166166616661666
16111611161111111171111116161111117111111616161116161616161111611611171116111111161616111616161616111161111711111616161616161161
16111611166111111777111116161111177711111666161116661616166111611666171116661111166616111666161616611161111711111616166116611161
16161611161111111171111116661111117111111611161116161616161111611116171111161111161116111616161616111161111711111616161616161161
16661666166611111111111111611111171711111611166616161616166611611661177116611171161116661616161616661161117711711661161616661666
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
82888222822882228888822282228882822882228222888888888888888888888888888888888888888882288288822882228882822282288222822288866688
82888828828282888888828888828828882888828882888888888888888888888888888888888888888888288288882882828828828288288282888288888888
82888828828282288888822288828828882888228882888888888888888888888888888888888888888888288222882882828828822288288222822288822288
82888828828282888888888288828828882888828882888888888888888888888888888888888888888888288282882882828828828288288882828888888888
82228222828282228888822288828288822282228882888888888888888888888888888888888888888882228222822282228288822282228882822288822288
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888

__sfx__
0028000014020140201402014020140201402014020140200d0200d0200d0200d0200d0200d0200d0200d02019020190201902019020190201902019020190201402014020140201402014010140101400014000
00280000080100801008010080100801008010080100801006010060100601006010060100601006010060100d0100d0100d0100d0100d0100d0100d0100d010080100801008010080100d0100d0100d0100d010
002800001e0201e0201e0201e0201e0201e0201e0201e0201e0201e0201e0201e0201e0201e0201e0201e0201d0201d0201d0201d0201d0201d0201d0201d0201b0201b0201b0201b0201d0201d0201e0101e010
__music__
00 00014244
02 00010244

