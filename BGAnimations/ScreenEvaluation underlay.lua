local magnitude = 0.1
local maxDistX = SCREEN_WIDTH*magnitude
local maxDistY = SCREEN_HEIGHT*magnitude

local t = Def.ActorFrame{}
if not(GAMESTATE:IsCourseMode()) then
	t[#t+1] = LoadSongBackground()..{
		Name="MouseXY";
		BeginCommand=cmd(scaletocover,0,0,SCREEN_WIDTH+maxDistX/4,SCREEN_BOTTOM+maxDistY/4;diffusealpha,0.3;);
	};
end;


local function getPosX()
	local offset = magnitude*(INPUTFILTER:GetMouseX()-SCREEN_CENTER_X)
	local neg
	if offset < 0 then
		neg = true
		offset = math.abs(offset)
		if offset > 1 then
			offset = math.min(2*math.sqrt(math.abs(offset)),maxDistX)
		end;
	else
		neg = false
		offset = math.abs(offset)
		if offset > 1 then
			offset = math.min(2*math.sqrt(math.abs(offset)),maxDistX)
		end;
	end;
	if neg then
		return SCREEN_CENTER_X-offset
	else 
		return SCREEN_CENTER_X+offset
	end;
end

local function getPosY()
	local offset = magnitude*(INPUTFILTER:GetMouseY()-SCREEN_CENTER_Y)
	local neg
	if offset < 0 then
		neg = true
		offset = math.abs(offset)
		if offset > 1 then
			offset = math.min(2*math.sqrt(offset),maxDistY)
		end;
	else
		neg = false
		offset = math.abs(offset)
		if offset > 1 then
			offset = math.min(2*math.sqrt(offset),maxDistY)
		end;
	end;
	if neg then
		return SCREEN_CENTER_Y-offset
	else 
		return SCREEN_CENTER_Y+offset
	end;
end

local function Update(self)
	t.InitCommand=cmd(SetUpdateFunction,Update);
    self:GetChild("MouseXY"):xy(getPosX(),getPosY())
end; 
t.InitCommand=cmd(SetUpdateFunction,Update);


return t
