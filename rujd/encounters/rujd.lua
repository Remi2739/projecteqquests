--local instance_id;
--local this_bit = 4;
--local lockout_win = 72;
--local lockout_loss = 2;
--local lockout_name = 'MPG_weaponry';
--local warnings;
--local minutes_remaining;
--local player_list;
-- items: 59571
  
local prisoners_freed=0; --3 to spawn #Prison_Guard_Talkor
local pg_chest=0; --killed #Prison_Guard_Talkor
local rpg_dead=0; --# of a_Rujarkian_prison_guard "dead" via npc or pc

local rpg_piyea=0;
local rpg_eneau=0;
local rpg_maziyae=0;

local boss_spawn=0;

function TM_Combat(e)
	if e.joined then
		eq.set_timer("orcbreath",7*1000)
	else
		eq.stop_timer("orcbreath");	
	end
end
function TM_Timer(e)
	if (e.timer == "orcbreath") then
		eq.stop_timer("orcbreath");		
		e.self:CastSpell(4192, e.self:GetHateTop():GetID()); -- Spell: Orc Breath
		eq.set_timer("orcbreath",45*1000)	
	end
end

function TMDevrak_Combat(e)
	if e.joined then
		eq.set_timer("ojunroar",7*1000)
	else
		eq.stop_timer("ojunroar");	
	end
end
function TMDevrak_Timer(e)
	if (e.timer == "ojunroar") then
		eq.stop_timer("ojunroar");		
		e.self:CastSpell(4140, e.self:GetHateTop():GetID()); -- Spell: Ojun Roar
		eq.set_timer("ojunroar",45*1000)	
	end
end

function TM_Devrak_Death(e)
	e.self:Emote("corpse crumples to the ground lifeless.  You search his lifeless body for some sign of a key, but are unable to find anything.  You do however notice a treasure chest out of the corner of your eye that you could have sworn wasn't there a minute ago.");
	eq.spawn2(245241,0,0,-487,1002,-34.75,288); --spawn chest with Heavy Orcish Prison Key
	local el = eq.get_entity_list();
	if not el:IsMobSpawnedByNpcTypeID(245199) and not el:IsMobSpawnedByNpcTypeID(245220) and not el:IsMobSpawnedByNpcTypeID(245200) then
		treasure_shroud();
	end;	
end
function TM_Dokorel_Death(e)
	e.self:Emote("corpse crumples to the ground lifeless.  You search his lifeless body for some sign of a key, but are unable to find anything.  You do however notice a treasure chest out of the corner of your eye that you could have sworn wasn't there a minute ago.");
	eq.spawn2(245241,0,0,295,459,-22,0); --spawn chest with Heavy Orcish Prison Key
	local el = eq.get_entity_list();
	if not el:IsMobSpawnedByNpcTypeID(245199) and not el:IsMobSpawnedByNpcTypeID(245220) and not el:IsMobSpawnedByNpcTypeID(245200) then
		treasure_shroud();
	end;	
end
function TM_Velrek_Death(e)
	e.self:Emote("corpse crumples to the ground lifeless.  You search his lifeless body for some sign of a key, but are unable to find anything.  You do however notice a treasure chest out of the corner of your eye that you could have sworn wasn't there a minute ago.");
	eq.spawn2(245241,0,0,115,1082,-24.25,384); --spawn chest with Heavy Orcish Prison Key
	local el = eq.get_entity_list();
	if not el:IsMobSpawnedByNpcTypeID(245199) and not el:IsMobSpawnedByNpcTypeID(245220) and not el:IsMobSpawnedByNpcTypeID(245200) then
		treasure_shroud();
	end;
end

  --x: 918.000000	y: -844.000000	z: -27.625000 north,  #Jealac_Yzinaql, iksar   245271 OK
  --x: 1106.000000	y: -1006.000000	z: -41.125000 near west, #Bacluu_Iggn, ogre    245280 ok
  --x: 1331.000000	y: -1154.000000	z: -27.250000 far west, #Yipzma_Tixxlea, gnome 245278 OK
  
  --x: 826.000000	y: -1351.000000	z: -44.125000 south, #Leannra_Nuadr, cat     245259 ok
  --x: 650.000000	y: -1048.000000	z: -38.875000 east,  #Gaddian_Opaleye, human   245279 OK

function Piyea_Spawn(e)
	if (rpg_piyea==1) then
		e.self:Emote("sneaks silently up behind the prisoner guard, dagger poised and ready.  With a single, silent motion the dagger finds its mark at the base of the orc's skull.  He crumples to the ground lifeless.");
		eq.set_timer("doanim",3000);
		eq.set_timer("245271",3500); --rpg
		eq.set_timer("245261",6000); --pris	
		eq.set_timer("depop",20000);		
	end
end
function Eneau_Spawn(e)
	if (rpg_eneau==1) then
		e.self:Emote("sneaks silently up behind the prisoner guard, dagger poised and ready.  With a single, silent motion the dagger finds its mark at the base of the orc's skull.  He crumples to the ground lifeless.");
		eq.set_timer("doanim",3000);
		eq.set_timer("245280",3500); --rpg
		--eq.set_timer("245271",3500); --rpg
		eq.set_timer("245272",6000); --pris	
		eq.set_timer("depop",20000);
	end
end
function Maziyae_Spawn(e)
	if (rpg_maziyae==1) then
		e.self:Emote("sneaks silently up behind the prisoner guard, dagger poised and ready.  With a single, silent motion the dagger finds its mark at the base of the orc's skull.  He crumples to the ground lifeless.");
		eq.set_timer("doanim",3000);
		eq.set_timer("245278",3500); --rpg
		eq.set_timer("245276",6000); --pris	
		eq.set_timer("depop",20000);		
		eq.set_timer("depop",15*1000);
	end
end

function RPG_Pris_Signal(e)
	if (e.signal==1) then
		e.self:DoAnim(27);
		e.self:Emote("struggles free of his bonds and stands up.  He nods in appreciation at your group and smiles.  He then fades into the shadows without a sound.");
		eq.set_timer("depop",10*1000);
	end
end

function RPG_Pris_Timer(e)
	if (e.timer == "depop") then
		eq.stop_timer("depop");
		eq.depop();
	end
end

function RPG_Spawn(e)
	eq.set_timer("check_nearby_npc",3000);
end

function RPG_Signal(e)
	if (e.signal==1) then
		--e.self:DoAnim(16);
		e.self:SetAppearance(3); --look dead
	end
	check_RPG();
end


function RPG_Timer(e)
	local my_guard_mobs=0;
	--ONLY CHECK MOBS WITH Y < -710
	--e.self:Say("in timer");
	if e.timer=="check_nearby_npc" then
		--check if any npc are in/from the room, if not
		--e.self:Say("checking for nearby mobs");
		local entity_list = eq.get_entity_list()
		local npc_list = entity_list:GetNPCList()

		for npc in npc_list.entries do
			--e.self:Say("npc" .. npc:GetID());
			if (npc.valid) then
				--e.self:Say("npc valid" .. npc:GetID());
				if (npc:GetSpawnPointY() < -710 and npc:CastToMob():GetRace()==361) then
					--e.self:Say("< -710" .. npc:GetID());
					if (e.self:CalculateDistance(npc:GetSpawnPointX(),npc:GetSpawnPointY(),npc:GetSpawnPointZ()) < 125 and e.self:CalculateDistance(npc:GetSpawnPointX(),npc:GetSpawnPointY(),npc:GetSpawnPointZ()) > 5) then
						--e.self:Say("vg" .. npc:GetID() .. " dist: " .. e.self:CalculateDistance(npc:GetSpawnPointX(),npc:GetSpawnPointY(),npc:GetSpawnPointZ()));
						my_guard_mobs=my_guard_mobs+1;
						break;
					end
				end
			end
		end	
		--my_guard_mobs=0;
		--rpg_eneau=1;
		--e.self:Say("guards: " .. my_guard_mobs)
		if (my_guard_mobs==0) then
			eq.stop_timer("check_nearby_npc");
			rpg_dead=rpg_dead+1;
			--north room
			--e.self:Say("spawny: " .. e.self:GetSpawnPointY())
			--#Jealac_Yzinaql (245261) saved by #Piyea_Frost (245228) 
			if (e.self:GetSpawnPointY()==-844) then
				rpg_piyea=1;
				eq.spawn2(245228, 0, 0, 908.3, -844, -31.4, 126); -- NPC: #Piyea_Frost
			--near west room
			--#Bacluu_Iggn (245272) saved by #Eneau_Welani (245225) 
			elseif (e.self:GetSpawnPointY()==-1006) then			
				rpg_eneau=1;
				eq.spawn2(245225, 0, 0, 1101, -999, -40, 186); -- NPC: #Eneau_Welani
				--e.self:Say("rpg_eneau: " .. rpg_eneau)
			--far west room
			--#Yipzma_Tixxlea (245276) saved by #Maziyae_Xanl`Utin (245217)
			elseif (e.self:GetSpawnPointY()==-1154) then
				rpg_maziyae=1;
				eq.spawn2(245217, 0, 0, 1340, -1152.3, -31.4, 368); -- NPC: #Maziyae_Xanl`Utin
			end
		end
		--e.self:Say("rpg_dead: " .. rpg_dead)
	end
end

function RPG_Death(e)
	eq.debug("RPG_Death(): GetSpawnPointY() = " .. e.self:GetSpawnPointY());
	--Gaddian_Opaleye guard
	if (e.self:GetSpawnPointY()==-1048) then
		eq.signal(245264,1); -- NPC: #Gaddian_Opaleye
		rpg_dead=rpg_dead+1;
	--Leannra_Nuadr guard
	elseif (e.self:GetSpawnPointY()==-1351) then
		eq.signal(245275,1); -- NPC: #Leannra_Nuadr
		rpg_dead=rpg_dead+1;
	end
	check_RPG();
end

function check_RPG()
	eq.debug("check_RPG(): rpg_dead = " .. rpg_dead .. " boss_spawn = " .. boss_spawn);
	if (rpg_dead>=5 and boss_spawn==0) then
		eq.zone_emote(MT.Yellow, "A great roar shakes the cavern walls.  Small pieces of debris fall from the walls and tumble to the ground at your feet.  The warden's voice snarls at you, 'You'll not leave this place alive softskins!  I'll be feeding your miserable carcasses to the prison dogs in the morning!");
		eq.spawn2(245296, 0, 0, 898, -1075, -18, 382);  --warden
		eq.spawn2(245284, 0, 0, 917, -1094, -20, 315);  --shaman
		boss_spawn=1;
	end
end

function treasure_shroud()

  eq.zone_emote(MT.Yellow,"Your victory has weakened a shroud of magic cloaking the dungeon's treasure."); 
end

function PG_Talkor_Spawn(e)
	eq.set_timer("path1",5*1000);
	eq.set_timer("path2",15*1000);
	eq.set_timer("depop",30*1000);
	e.self:SetRunning(true);
end
function PG_Talkor_Combat(e)
	if e.joined then
		eq.stop_timer("depop");
		eq.set_timer("gaze",7*1000);
	else
		eq.set_timer("depop",30*1000);
		eq.stop_timer("gaze");		
	end
end
function PG_Talkor_Timer(e)
	if (e.timer == "path1") then
		eq.stop_timer("path1");
		e.self:MoveTo(-491, 304, -26, 385,true);
		e.self:Emote("sniffs the air around him. 'I smell softskins!  Where are my taskmasters!");
	elseif (e.timer == "path2") then
		eq.stop_timer("path2");
		e.self:MoveTo(-666, 316, -23, 192,true);
		e.self:Emote("'s eyes grow narrow as he begins to suspect something is amiss.  He bolts from the room roaring an alert that echoes through the caverns.");
	elseif (e.timer == "depop") then
		eq.stop_timer("depop");
		eq.depop();
	elseif (e.timer=="gaze") then
		eq.stop_timer("gaze");		
		e.self:CastSpell(4416, e.self:GetHateTop():GetID()); -- Spell: Gaze of Talkor
		eq.set_timer("gaze",30*1000);
	end
end
function PG_Talkor_Death(e)
	pg_chest=1;
	treasure_shroud();
end

function Prisoner_Say(e)
	if (e.message:findi("hail")) then
		e.self:Emote("struggles against his shackles as you approach him. 'Who are you?  Clearly you're not orcs so I guess you can't be all bad.  The brotherhood sent you to free us?  You'll need to get the keys from the taskmasters in order to free us.  Three taskmasters for three prisoners, hurry before the orcs are alerted to your presence.");
	end
end
function Prisoner_Trade(e)
	local item_lib = require('items');
	if (item_lib.check_turn_in(e.trade, {item1 = 59571})) then --Heavy Orcish Prison Key
		e.self:SetAppearance(0); --stand up
		eq.set_timer("depop",15*1000);
		prisoners_freed=prisoners_freed+1;
	if (prisoners_freed >= 3) then --im the last prisoner, different emote
		e.self:Emote("grins as the shackles fall away.  'Thank you for freeing us, but your quest is not nearly finished.  Five of our brothers were dragged away not long ago to be executed in the gladiator pits.  You must hurry and free them!  The orcs will most certainly move quickly to kill our friends if they are alerted to our presence.  You'll have to split up and coordinate your ambush if we hope to free them all.  The three of us will meet you there, but you must keep the orcs busy while we free our friends.  Hurry! I think I hear the metal boots of that foul warden approaching, you must keep him from sounding the alarm!  He then fades into the shadows without a sound.");
		eq.spawn2(245290, 0, 0, -290, 304, -23, 384); --#Prison_Guard_Talkor				
	else
		e.self:Emote("'s eyes gleam as the key clicks in the lock and the shackles fall to the ground. 'Thanks you friend, I knew the brotherhood would send someone for us.  Hurry and free the others before the warden returns.");
	end
		e.other:AddEXP(397650);
	end
	item_lib.return_items(e.self, e.other, e.trade);
end
function Prisoner_Timer(e)
	if (e.timer == "depop") then
		eq.stop_timer("depop");
		eq.depop();
	elseif (e.timer=="doanim") then
		eq.stop_timer("doanim");
		e.self:DoAnim(87);
	elseif (e.timer=="245280") then
		eq.stop_timer("245280");
		eq.signal(245280,1); --rpg
	elseif (e.timer=="245271") then
		eq.stop_timer("245271");
		eq.signal(245271,1); --rpg
	elseif (e.timer=="245278") then
		eq.stop_timer("245272");
		eq.signal(245278,1); -- NPC: a_Rujarkian_prison_guard
	elseif (e.timer=="245272") then
		eq.stop_timer("245272");
		eq.signal(245272,1); -- NPC: #Bacluu_Iggn
	elseif (e.timer=="245276") then
		eq.stop_timer("245276");
		eq.signal(245276,1); -- NPC: #Yipzma_Tixxlea
	elseif (e.timer=="245261") then
		eq.stop_timer("245261");
		eq.signal(245261,1); -- NPC: #Jealac_Yzinaql
	end
end

function Warden_Combat(e)
	if e.joined then
		eq.set_timer("roar",6.5*1000);
		eq.set_timer("aggrolink", 3 * 1000);
		eq.set_next_hp_event(20);
	else
		eq.stop_timer("roar");
		eq.stop_timer("aggrolink");
	end
end

function Warden_Timer(e)
	if (e.timer == "roar") then
		e.self:CastSpell(4417, e.self:GetHateTop():GetID()); -- Spell: Warden's Roar
	elseif (e.timer == "aggrolink") then
		local npc_list =  eq.get_entity_list():GetNPCList();
		for npc in npc_list.entries do
		if (npc.valid and not npc:IsEngaged() and (npc:GetNPCTypeID() == 245284)) then
			npc:AddToHateList(e.self:GetHateRandom(),1); -- add #High_Shaman_Yenner (245284) to aggro list if alive
		end
		end
	end
end

function Shaman_Combat(e)
	if e.joined then
		eq.set_timer("orcbreath",7*1000);
		eq.set_timer("aggrolink", 3 * 1000);
		eq.set_next_hp_event(20);
	else
		eq.stop_timer("orcbreath");
		eq.stop_timer("aggrolink");
	end
end

function Shaman_Timer(e)
	if (e.timer == "orcbreath") then
		eq.stop_timer("orcbreath");		
		e.self:CastSpell(4192, e.self:GetHateTop():GetID()); -- Spell: Orc Breath
		eq.set_timer("orcbreath",45*1000);
	elseif (e.timer == "aggrolink") then
		local npc_list =  eq.get_entity_list():GetNPCList();
		for npc in npc_list.entries do
		if (npc.valid and not npc:IsEngaged() and (npc:GetNPCTypeID() == 245296)) then
			npc:AddToHateList(e.self:GetHateRandom(),1); -- add #Warden_Neyremal (245296) to aggro list if alive
		end
		end
	end
end

function Named_Hp(e)
	if (e.hp_event == 20) then
		e.self:Emote("goes into a berserker frenzy!");
		e.self:HealDamage(100000);
        	eq.modify_npc_stat("min_hit", "1040");
        	eq.modify_npc_stat("max_hit", "2370");
	end
end

function Warden_Death(e)
	check_chests();
end
function Shaman_Death(e)
	check_chests();
end
function check_chests()
	local el = eq.get_entity_list();
	if not el:IsMobSpawnedByNpcTypeID(245296) and not el:IsMobSpawnedByNpcTypeID(245284) then
		eq.zone_emote(MT.Yellow,"Your victory has shattered the shroud of magic surrounding the dungeon's treasure");
		eq.zone_emote(MT.Yellow,"The last of the prisoners has escaped and the warden lies dead at your feet.  You have done well.");
		eq.spawn2(245297,0,0, 867.00,-1043.00,0,192); --#Yenner`s_Decorative_Chest		
		if not el:IsMobSpawnedByNpcTypeID(245199) and not el:IsMobSpawnedByNpcTypeID(245220) and not el:IsMobSpawnedByNpcTypeID(245200) then
			eq.spawn2(245295,0,0, 919.00,-1058.00,-21.50,320); --#Taskmaster`s_Stone_Chest
		end;	
		if (pg_chest==1) then
			eq.spawn2(245287,0,0,877,-1093,21.50, 70) --#Talkor`s_Bloody_Chest
		end;

		local dz = eq.get_expedition()
		if dz.valid then
			dz:AddReplayLockout(eq.seconds("4d12h"))
		end
	end;
end

function Trash_Hp(e)
	if (e.hp_event == 40) then
		eq.set_timer("frenzy", math.random(1,5) * 1000);
	end
end

function Trash_Combat(e)
	if e.joined then
		eq.set_next_hp_event(40);
	end
end

function Trash_Timer(e)
	if (e.timer == "frenzy") then
		e.self:Emote("goes into a berserker frenzy!");
		e.self:HealDamage(7000);
		e.self:SetSpecialAbility(4, 1);
		eq.stop_timer("frenzy");
		eq.set_timer("down", 30 * 1000);
			local rand = math.random(1,2); 
			if (rand == 1) then
        			eq.modify_npc_stat("min_hit", "220");
        			eq.modify_npc_stat("max_hit", "1295");
			elseif (rand == 2) then
        			eq.modify_npc_stat("min_hit", "1578");
        			eq.modify_npc_stat("max_hit", "2053");
			end
	elseif (e.timer == "down") then
		e.self:Emote("slows as his frenzy ends.");
        	eq.modify_npc_stat("min_hit", "205");
        	eq.modify_npc_stat("max_hit", "660");
		e.self:SetSpecialAbility(4, 0);
		eq.stop_timer("down");
		eq.set_next_hp_event(40);
	elseif (e.timer == "check") then
		eq.stop_timer("check");
		local level = e.self:GetLevel();
			if(level <= 64) then
			e.self:SetSpecialAbility(14, 0);
			end

	end
end

function Charmable_Trash_Spawn(e)
	eq.set_timer("check", 3 * 1000);
end

function event_encounter_load(e)

  eq.register_npc_event('rujd', Event.combat,	245206, Trash_Combat); --a_Rujarkian_sentry (245206)(war)
  eq.register_npc_event('rujd', Event.timer,	245206, Trash_Timer);--a_Rujarkian_sentry (245206)(war)
  eq.register_npc_event('rujd', Event.hp,	245206, Trash_Hp);--a_Rujarkian_sentry (245206)(war)
  eq.register_npc_event('rujd', Event.combat,	245193, Trash_Combat); --a_Rujarkian_sentry (245193)(rog)
  eq.register_npc_event('rujd', Event.timer,	245193, Trash_Timer);--a_Rujarkian_sentry (245193)(rog)
  eq.register_npc_event('rujd', Event.hp,	245193, Trash_Hp);--a_Rujarkian_sentry (245193)(rog)
  eq.register_npc_event('rujd', Event.combat,	245227, Trash_Combat); --a_Rujarkian_warrior (245227)
  eq.register_npc_event('rujd', Event.timer,	245227, Trash_Timer);--a_Rujarkian_warrior (245227)
  eq.register_npc_event('rujd', Event.hp,	245227, Trash_Hp);--a_Rujarkian_warrior (245227)
  eq.register_npc_event('rujd', Event.combat,	245230, Trash_Combat); --a_Rujarkian_shaman (245230)
  eq.register_npc_event('rujd', Event.timer,	245230, Trash_Timer);--a_Rujarkian_shaman (245230)
  eq.register_npc_event('rujd', Event.hp,	245230, Trash_Hp);--a_Rujarkian_shaman (245230)
  eq.register_npc_event('rujd', Event.combat,	245236, Trash_Combat); --a_Rujarkian_healer (245236)
  eq.register_npc_event('rujd', Event.timer,	245236, Trash_Timer);--a_Rujarkian_healer (245236)
  eq.register_npc_event('rujd', Event.hp,	245236, Trash_Hp);--a_Rujarkian_healer (245236)
  eq.register_npc_event('rujd', Event.combat,	245231, Trash_Combat); --a_Rujarkian_blackhand (245231)
  eq.register_npc_event('rujd', Event.timer,	245231, Trash_Timer);--a_Rujarkian_blackhand (245231)
  eq.register_npc_event('rujd', Event.hp,	245231, Trash_Hp);--a_Rujarkian_blackhand (245231)
  eq.register_npc_event('rujd', Event.spawn,	245231, Charmable_Trash_Spawn);--a_Rujarkian_blackhand (245231)
  eq.register_npc_event('rujd', Event.spawn,	245227, Charmable_Trash_Spawn);--a_Rujarkian_warrior (245227)
  eq.register_npc_event('rujd', Event.spawn,	245230, Charmable_Trash_Spawn);--a_Rujarkian_shaman (245230)
	
  eq.register_npc_event('rujd', Event.death_complete, 245199, TM_Devrak_Death); --#Taskmaster_Devrak 
  eq.register_npc_event('rujd', Event.death_complete, 245220, TM_Dokorel_Death); --#Taskmaster_Dokorel 
  eq.register_npc_event('rujd', Event.death_complete, 245200, TM_Velrek_Death); --#Taskmaster_Velrek
 
  eq.register_npc_event('rujd', Event.timer, 245220, TM_Timer); --#Taskmaster_Dokorel 
  eq.register_npc_event('rujd', Event.timer, 245200, TM_Timer); --#Taskmaster_Velrek
  eq.register_npc_event('rujd', Event.combat, 245199, TMDevrak_Combat); --#Taskmaster_Devrak 
  eq.register_npc_event('rujd', Event.timer, 245199, TMDevrak_Timer); --#Taskmaster_Devrak 
  eq.register_npc_event('rujd', Event.combat, 245220, TM_Combat); --#Taskmaster_Dokorel 
  eq.register_npc_event('rujd', Event.combat, 245200, TM_Combat); --#Taskmaster_Velrek  
  
  eq.register_npc_event('rujd', Event.combat,	245296, Warden_Combat); --#Warden_Neyremal 
  eq.register_npc_event('rujd', Event.combat,	245284, Shaman_Combat); --#High_Shaman_Yenner
  eq.register_npc_event('rujd', Event.timer,	245296, Warden_Timer); --#Warden_Neyremal 
  eq.register_npc_event('rujd', Event.timer,	245284, Shaman_Timer); --#High_Shaman_Yenner  
  eq.register_npc_event('rujd', Event.death_complete,	245296, Warden_Death); --#Warden_Neyremal 
  eq.register_npc_event('rujd', Event.death_complete,	245284, Shaman_Death); --#High_Shaman_Yenner
  eq.register_npc_event('rujd', Event.hp,	245296, Named_Hp); --#Warden_Neyremal 
  eq.register_npc_event('rujd', Event.hp,	245284, Named_Hp); --#High_Shaman_Yenner  

  eq.register_npc_event('rujd', Event.death_complete,	245290, PG_Talkor_Death);  
  eq.register_npc_event('rujd', Event.spawn,			245290, PG_Talkor_Spawn);
  eq.register_npc_event('rujd', Event.timer,			245290, PG_Talkor_Timer);
  eq.register_npc_event('rujd', Event.combat,			245290, PG_Talkor_Combat);
  
  eq.register_npc_event('rujd', Event.trade,	245217, Prisoner_Trade); --#Maziyae_Xanl`Utin
  eq.register_npc_event('rujd', Event.trade,	245228, Prisoner_Trade); --#Piyea_Frost`Utin
  eq.register_npc_event('rujd', Event.trade,	245225, Prisoner_Trade); --#Eneau_Welani`Utin
  eq.register_npc_event('rujd', Event.say,		245217, Prisoner_Say); --#Maziyae_Xanl`Utin
  eq.register_npc_event('rujd', Event.say,		245228, Prisoner_Say); --#Piyea_Frost`Utin
  eq.register_npc_event('rujd', Event.say,		245225, Prisoner_Say); --#Eneau_Welani`Utin
  eq.register_npc_event('rujd', Event.timer,	245217, Prisoner_Timer); --#Maziyae_Xanl`Utin
  eq.register_npc_event('rujd', Event.timer,	245228, Prisoner_Timer); --#Piyea_Frost`Utin
  eq.register_npc_event('rujd', Event.timer,	245225, Prisoner_Timer); --#Eneau_Welani`Utin
  eq.register_npc_event('rujd', Event.spawn,	245217, Maziyae_Spawn); --#Maziyae_Xanl`Utin
  eq.register_npc_event('rujd', Event.spawn,	245228, Piyea_Spawn); --#Piyea_Frost`Utin
  eq.register_npc_event('rujd', Event.spawn,	245225, Eneau_Spawn); --#Eneau_Welani`Utin   

  eq.register_npc_event('rujd', Event.spawn,			245271, RPG_Spawn);    --a_Rujarkian_prison_guard (npc killed)
  eq.register_npc_event('rujd', Event.spawn,			245278, RPG_Spawn);    --a_Rujarkian_prison_guard (npc killed)
  eq.register_npc_event('rujd', Event.spawn,			245280, RPG_Spawn);    --a_Rujarkian_prison_guard (npc killed)   
  eq.register_npc_event('rujd', Event.timer,			245271, RPG_Timer);    --a_Rujarkian_prison_guard (npc killed)
  eq.register_npc_event('rujd', Event.timer,			245278, RPG_Timer);    --a_Rujarkian_prison_guard (npc killed)
  eq.register_npc_event('rujd', Event.timer,			245280, RPG_Timer);    --a_Rujarkian_prison_guard (npc killed)
  eq.register_npc_event('rujd', Event.signal,			245271, RPG_Signal);    --a_Rujarkian_prison_guard (npc killed)
  eq.register_npc_event('rujd', Event.signal,			245278, RPG_Signal);    --a_Rujarkian_prison_guard (npc killed)
  eq.register_npc_event('rujd', Event.signal,			245280, RPG_Signal);    --a_Rujarkian_prison_guard (npc killed)   
  eq.register_npc_event('rujd', Event.death_complete,	245259, RPG_Death);		--a_Rujarkian_prison_guard (pc killed)
  eq.register_npc_event('rujd', Event.death_complete,	245279, RPG_Death);		--a_Rujarkian_prison_guard (pc killed)  
    
  eq.register_npc_event('rujd', Event.signal,			245261, RPG_Pris_Signal); --#Jealac_Yzinaql (245261)
  eq.register_npc_event('rujd', Event.signal,			245272, RPG_Pris_Signal); --#Bacluu_Iggn (245272)
  eq.register_npc_event('rujd', Event.signal,			245276, RPG_Pris_Signal); --#Yipzma_Tixxlea (245276)
  eq.register_npc_event('rujd', Event.signal,			245264, RPG_Pris_Signal); --#Gaddian_Opaleye (245264)
  eq.register_npc_event('rujd', Event.signal,			245275, RPG_Pris_Signal); --#Leannra_Nuadr (245275)
  eq.register_npc_event('rujd', Event.timer,			245261, RPG_Pris_Timer); --#Jealac_Yzinaql (245261)
  eq.register_npc_event('rujd', Event.timer,			245272, RPG_Pris_Timer); --#Bacluu_Iggn (245272)
  eq.register_npc_event('rujd', Event.timer,			245276, RPG_Pris_Timer); --#Yipzma_Tixxlea (245276)
  eq.register_npc_event('rujd', Event.timer,			245264, RPG_Pris_Timer); --#Gaddian_Opaleye (245264)
  eq.register_npc_event('rujd', Event.timer,			245275, RPG_Pris_Timer); --#Leannra_Nuadr (245275)  
end

