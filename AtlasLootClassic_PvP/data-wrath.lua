-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)
local select = _G.select
local string = _G.string
local format = string.format

-- WoW

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local addonname, private = ...
local AtlasLoot = _G.AtlasLoot
if AtlasLoot:GameVersion_LT(AtlasLoot.WRATH_VERSION_NUM) then return end
local data = AtlasLoot.ItemDB:Add(addonname, 1, AtlasLoot.WRATH_VERSION_NUM)

local AL = AtlasLoot.Locales
local ALIL = AtlasLoot.IngameLocales

local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", 1, nil, true)
local ALLIANCE_DIFF
local HORDE_DIFF
local LOAD_DIFF
if UnitFactionGroup("player") == "Horde" then
	HORDE_DIFF = data:AddDifficulty(FACTION_HORDE, "horde", nil, 1)
	ALLIANCE_DIFF = data:AddDifficulty(FACTION_ALLIANCE, "alliance", nil, 1)
	LOAD_DIFF = HORDE_DIFF
else
	ALLIANCE_DIFF = data:AddDifficulty(FACTION_ALLIANCE, "alliance", nil, 1)
	HORDE_DIFF = data:AddDifficulty(FACTION_HORDE, "horde", nil, 1)
	LOAD_DIFF = ALLIANCE_DIFF
end
local SET1_DIFF = data:AddDifficulty(format(AL["Savage %s"], ""), "set1", nil, 1)
local SET2_DIFF = data:AddDifficulty(format(AL["Hateful %s"], ""), "set2", nil, 1)
local SET3_DIFF = data:AddDifficulty(format(AL["Deadly %s"], ""), "set3", nil, 1)

local NORMAL_ITTYPE = data:AddItemTableType("Item", "Item")
local SET_ITTYPE = data:AddItemTableType("Set", "Item")
local ICON_ITTYPE = data:AddItemTableType("Dummy")

local QUEST_EXTRA_ITTYPE = data:AddExtraItemTableType("Quest")
local PRICE_EXTRA_ITTYPE = data:AddExtraItemTableType("Price")
local SET_EXTRA_ITTYPE = data:AddExtraItemTableType("Set")

local PVP_CONTENT = data:AddContentType(AL["Battlegrounds"], ATLASLOOT_PVP_COLOR)
local ARENA_CONTENT = data:AddContentType(AL["Arena"], ATLASLOOT_PVP_COLOR)
local OPEN_WORLD_CONTENT = data:AddContentType(AL["Open World"], ATLASLOOT_PVP_COLOR)
local GENERAL_CONTENT = data:AddContentType(GENERAL, ATLASLOOT_RAID40_COLOR)

local HORDE, ALLIANCE, RANK_FORMAT = "Horde", "Alliance", AL["|cff33ff99Rank:|r %s"]
local BLIZZARD_NYI = " |cff00ccff<NYI |T130946:12:20:0:0:32:16:4:28:0:16|t>|r"

local _DUMMY_SET = {
	name = AL["Sets"],
	TableType = SET_ITTYPE,
	[SET1_DIFF] = {
		{ 1,    3000780 }, -- Warlock
		{ 3,    3000777 }, -- Priest / Heal
        { 4,    3000778 }, -- Priest / Shadow
        { 6,    3000776 }, -- Rogue
		{ 8,    3000772 }, -- Hunter
		{ 10,   3000780 }, -- Warrior / DD
        { 13,   3000768 }, -- Deathknight
		{ 16,   3000779 }, -- Mage
        { 18,   3000773 }, -- Druid / Heal
        { 19,   3000774 }, -- Druid / Owl
        { 20,   3000775 }, -- Druid / Feral
        { 22,   3000771 }, -- Shaman / Heal
        { 23,   3000769 }, -- Shaman / Ele
        { 24,   3000770 }, -- Shaman / Enh
        { 26,   3000767 }, -- Paladin / Heal
        { 27,   3000766 }, -- Paladin / DD
	},
	[SET2_DIFF] = {
		{ 1,    3001780 }, -- Warlock
		{ 3,    3001777 }, -- Priest / Heal
        { 4,    3001778 }, -- Priest / Shadow
        { 6,    3001776 }, -- Rogue
		{ 8,    3001772 }, -- Hunter
		{ 10,   3001780 }, -- Warrior / DD
        { 13,   3001768 }, -- Deathknight
		{ 16,   3001779 }, -- Mage
        { 18,   3001773 }, -- Druid / Heal
        { 19,   3001774 }, -- Druid / Owl
        { 20,   3001775 }, -- Druid / Feral
        { 22,   3001771 }, -- Shaman / Heal
        { 23,   3001769 }, -- Shaman / Ele
        { 24,   3001770 }, -- Shaman / Enh
        { 26,   3001767 }, -- Paladin / Heal
        { 27,   3001766 }, -- Paladin / DD
	},
	[SET3_DIFF] = {
		{ 1,    3002780 }, -- Warlock
		{ 3,    3002777 }, -- Priest / Heal
        { 4,    3002778 }, -- Priest / Shadow
        { 6,    3002776 }, -- Rogue
		{ 8,    3002772 }, -- Hunter
		{ 10,   3002780 }, -- Warrior / DD
        { 13,   3002768 }, -- Deathknight
		{ 16,   3002779 }, -- Mage
        { 18,   3002773 }, -- Druid / Heal
        { 19,   3002774 }, -- Druid / Owl
        { 20,   3002775 }, -- Druid / Feral
        { 22,   3002771 }, -- Shaman / Heal
        { 23,   3002769 }, -- Shaman / Ele
        { 24,   3002770 }, -- Shaman / Enh
        { 26,   3002767 }, -- Paladin / Heal
        { 27,   3002766 }, -- Paladin / DD
	},
}

data["PvPMountsWrath"] = {
	name = ALIL["Mounts"],
	ContentType = GENERAL_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	CorrespondingFields = private.MOUNTS_LINK,
	items = {
		{ -- PvPMountsPvP
			name = ALIL["Mounts"],
			[ALLIANCE_DIFF] = {
				{ 1,  19030 }, -- Stormpike Battle Charger
				{ 3,  29467 }, -- Black War Ram
				{ 4,  29465 }, -- Black Battlestrider
				{ 5,  29468 }, -- Black War Steed Bridle
				{ 6,  29471 }, -- Reins of the Black War Tiger
				{ 7,  35906 }, -- Reins of the Black War Elekk
				{ 16,  46708 }, -- Deadly Gladiator's Frost Wyrm
				{ 17,  46171 }, -- Furious  Gladiator's Frost Wyrm
				{ 18,  47840 }, -- Relentless Gladiator's Frost Wyrm
				{ 19,  50435 }, -- Wrathful Gladiator's Frost Wyrm
			},
			[HORDE_DIFF] = {
				{ 1, 19029  }, -- Horn of the Frostwolf Howler
				{ 3, 29469 }, -- Horn of the Black War Wolf
				{ 4, 29466 }, -- Black War Kodo
				{ 5, 29472 }, -- Whistle of the Black War Raptor
				{ 6, 29470 }, -- Red Skeletal Warhorse
				{ 7, 34129 }, -- Swift Warstrider
				{ 16,  46708 }, -- Deadly Gladiator's Frost Wyrm
				{ 17,  46171 }, -- Furious  Gladiator's Frost Wyrm
				{ 18,  47840 }, -- Relentless Gladiator's Frost Wyrm
				{ 19,  50435 }, -- Wrathful Gladiator's Frost Wyrm
			},
		},
	},
}

data["ArenaS5PvP"] = {
	name = format(AL["Season %s"], "5"),
	ContentType = ARENA_CONTENT,
	LoadDifficulty = LOAD_DIFF,
	TableType = NORMAL_ITTYPE,
	items = {
		{
			name = AL["Sets"],
			TableType = SET_ITTYPE,
			[SET1_DIFF] = {
				{ 1,    3000780 }, -- Warlock
				{ 3,    3000777 }, -- Priest / Heal
				{ 4,    3000778 }, -- Priest / Shadow
				{ 6,    3000776 }, -- Rogue
				{ 8,    3000772 }, -- Hunter
				{ 10,   3000765 }, -- Warrior / DD
				{ 13,   3000768 }, -- Deathknight
				{ 16,   3000779 }, -- Mage
				{ 18,   3000773 }, -- Druid / Heal
				{ 19,   3000774 }, -- Druid / Owl
				{ 20,   3000775 }, -- Druid / Feral
				{ 22,   3000771 }, -- Shaman / Heal
				{ 23,   3000769 }, -- Shaman / Ele
				{ 24,   3000770 }, -- Shaman / Enh
				{ 26,   3000767 }, -- Paladin / Heal
				{ 27,   3000766 }, -- Paladin / DD
			},
			[SET2_DIFF] = {
				{ 1,    3001780 }, -- Warlock
				{ 3,    3001777 }, -- Priest / Heal
				{ 4,    3001778 }, -- Priest / Shadow
				{ 6,    3001776 }, -- Rogue
				{ 8,    3001772 }, -- Hunter
				{ 10,   3001765 }, -- Warrior / DD
				{ 13,   3001768 }, -- Deathknight
				{ 16,   3001779 }, -- Mage
				{ 18,   3001773 }, -- Druid / Heal
				{ 19,   3001774 }, -- Druid / Owl
				{ 20,   3001775 }, -- Druid / Feral
				{ 22,   3001771 }, -- Shaman / Heal
				{ 23,   3001769 }, -- Shaman / Ele
				{ 24,   3001770 }, -- Shaman / Enh
				{ 26,   3001767 }, -- Paladin / Heal
				{ 27,   3001766 }, -- Paladin / DD
			},
			[SET3_DIFF] = {
				{ 1,    3002780 }, -- Warlock
				{ 3,    3002777 }, -- Priest / Heal
				{ 4,    3002778 }, -- Priest / Shadow
				{ 6,    3002776 }, -- Rogue
				{ 8,    3002772 }, -- Hunter
				{ 10,   3002765 }, -- Warrior / DD
				{ 13,   3002768 }, -- Deathknight
				{ 16,   3002779 }, -- Mage
				{ 18,   3002773 }, -- Druid / Heal
				{ 19,   3002774 }, -- Druid / Owl
				{ 20,   3002775 }, -- Druid / Feral
				{ 22,   3002771 }, -- Shaman / Heal
				{ 23,   3002769 }, -- Shaman / Ele
				{ 24,   3002770 }, -- Shaman / Enh
				{ 26,   3002767 }, -- Paladin / Heal
				{ 27,   3002766 }, -- Paladin / DD
			},
		},
		{
			name = AL["Weapons"].." - "..AL["One-Handed"],
			[SET1_DIFF] = {
				{ 1, 42216 }, -- Gladiator's Shanker
				{ 2, 42217 }, -- Gladiator's Shiv
				{ 3, 42215 }, -- Gladiator's Mutilator

				{ 5, 42222 }, -- Gladiator's Pummeler
				{ 6, 42221 }, -- Gladiator's Bonecracker

				{ 8, 42224 }, -- Gladiator's Slicer
				{ 9, 42223 }, -- Gladiator's Quickblade

				{ 11, 42206 }, -- Gladiator's Cleaver
				{ 12, 42213 }, -- Gladiator's Hacker
				{ 13, 42212 }, -- Gladiator's Chopper

				{ 15, 42214 }, -- Gladiator's Waraxe

				{ 16, 42343 }, -- Gladiator's Spellblade
				{ 20, 42344 }, -- Gladiator's Gavel

				{ 26, 42218 }, -- Gladiator's Right Ripper
				{ 27, 42220 }, -- Gladiator's Left Ripper
				{ 28, 42219 }, -- Gladiator's Left Render
			},
			[SET2_DIFF] = {
				{ 1, 42241 }, -- Gladiator's Shanker
				{ 2, 42247 }, -- Gladiator's Shiv
				{ 3, 42254 }, -- Gladiator's Mutilator

				{ 5, 42274 }, -- Gladiator's Pummeler
				{ 6, 42279 }, -- Gladiator's Bonecracker

				{ 8, 42284 }, -- Gladiator's Slicer
				{ 9, 42289 }, -- Gladiator's Quickblade

				{ 11, 42207 }, -- Gladiator's Cleaver
				{ 12, 42226 }, -- Gladiator's Hacker
				{ 13, 42231 }, -- Gladiator's Chopper

				{ 15, 42236 }, -- Gladiator's Waraxe

				{ 16, 42345 }, -- Gladiator's Spellblade
				{ 20, 42351 }, -- Gladiator's Gavel

				{ 26, 42259 }, -- Gladiator's Right Ripper
				{ 27, 42269 }, -- Gladiator's Left Ripper
				{ 28, 42264 }, -- Gladiator's Left Render
			},
			[SET3_DIFF] = {
				{ 1, 42242 }, -- Gladiator's Shanker
				{ 2, 42248 }, -- Gladiator's Shiv
				{ 3, 42255 }, -- Gladiator's Mutilator

				{ 5, 42275 }, -- Gladiator's Pummeler
				{ 6, 42280 }, -- Gladiator's Bonecracker

				{ 8, 42285 }, -- Gladiator's Slicer
				{ 9, 42290 }, -- Gladiator's Quickblade

				{ 11, 42208 }, -- Gladiator's Cleaver
				{ 12, 42227 }, -- Gladiator's Hacker
				{ 13, 42232 }, -- Gladiator's Chopper

				{ 15, 42237 }, -- Gladiator's Waraxe

				{ 16, 42346 }, -- Gladiator's Spellblade
				{ 20, 42352 }, -- Gladiator's Gavel

				{ 26, 42260 }, -- Gladiator's Right Ripper
				{ 27, 42270 }, -- Gladiator's Left Ripper
				{ 28, 42265 }, -- Gladiator's Left Render
			},
		},
		{
			name = AL["Weapons"].." - "..AL["Two-Handed"],
			[SET1_DIFF] = {
				{ 1, 42297 }, -- Gladiator's Greatsword
				{ 3, 42294 }, -- Gladiator's Decapitator
				{ 7, 42295 }, -- Gladiator's Bonegrinder
				{ 10, 42296 }, -- Gladiator's Pike
				{ 16, 44415 }, -- Gladiator's War Staff
				{ 17, 42356 }, -- Gladiator's Battle Staff
				{ 18, 44416 }, -- Gladiator's Focus Staff
				{ 20, 42382 }, -- Gladiator's Energy Staff
				{ 22, 42388 }, -- Gladiator's Staff
			},
			[SET2_DIFF] = {
				{ 1, 42331 }, -- Gladiator's Greatsword
				{ 3, 42316 }, -- Gladiator's Decapitator
				{ 7, 42321 }, -- Gladiator's Bonegrinder
				{ 10, 42326 }, -- Gladiator's Pike
				{ 16, 44417 }, -- Gladiator's War Staff
				{ 17, 42359 }, -- Gladiator's Battle Staff
				{ 18, 44418 }, -- Gladiator's Focus Staff
				{ 20, 42383 }, -- Gladiator's Energy Staff
				{ 22, 42389 }, -- Gladiator's Staff
			},
			[SET3_DIFF] = {
				{ 1, 42332 }, -- Gladiator's Greatsword
				{ 3, 42317 }, -- Gladiator's Decapitator
				{ 7, 42322 }, -- Gladiator's Bonegrinder
				{ 10, 42327 }, -- Gladiator's Pike
				{ 16, 44419 }, -- Gladiator's War Staff
				{ 17, 42362 }, -- Gladiator's Battle Staff
				{ 18, 44420 }, -- Gladiator's Focus Staff
				{ 20, 42384 }, -- Gladiator's Energy Staff
				{ 22, 42390 }, -- Gladiator's Staff
			},
		},
		{
			name = AL["Weapons"].." - "..AL["Ranged"],
			[SET1_DIFF] = {
				{ 1, 42445 }, -- Gladiator's Longbow
				{ 3, 42446 }, -- Gladiator's Heavy Crossbow
				{ 5, 42447 }, -- Gladiator's Rifle
				{ 7, 42444 }, -- Gladiator's War Edge
				{ 16, 42448 }, -- Gladiator's Touch of Defeat
				{ 17, 42511 }, -- Gladiator's Baton of Light
				{ 18, 42517 }, -- Gladiator's Piercing Touch
			},
			[SET2_DIFF] = {
				{ 1, 42489 }, -- Gladiator's Longbow
				{ 3, 42494 }, -- Gladiator's Heavy Crossbow
				{ 5, 42484 }, -- Gladiator's Rifle
				{ 7, 42449 }, -- Gladiator's War Edge
				{ 16, 42501 }, -- Gladiator's Touch of Defeat
				{ 17, 42512 }, -- Gladiator's Baton of Light
				{ 18, 42518 }, -- Gladiator's Piercing Touch
			},
			[SET3_DIFF] = {
				{ 1, 42490 }, -- Gladiator's Longbow
				{ 3, 42495 }, -- Gladiator's Heavy Crossbow
				{ 5, 42485 }, -- Gladiator's Rifle
				{ 7, 42450 }, -- Gladiator's War Edge
				{ 16, 42502 }, -- Gladiator's Touch of Defeat
				{ 17, 42513 }, -- Gladiator's Baton of Light
				{ 18, 42519 }, -- Gladiator's Piercing Touch
			},
		},
		{
			name = AL["Weapons"].." - "..ALIL["Off Hand"],
			[SET1_DIFF] = {
				{ 1, 42523 }, -- Gladiator's Endgame
				{ 2, 42535 }, -- Gladiator's Grimoire
				{ 16, 42529 }, -- Gladiator's Reprieve
			},
			[SET2_DIFF] = {
				{ 1, 42524 }, -- Gladiator's Endgame
				{ 2, 42536 }, -- Gladiator's Grimoire
				{ 16, 42530 }, -- Gladiator's Reprieve
			},
			[SET3_DIFF] = {
				{ 1, 42525 }, -- Gladiator's Endgame
				{ 2, 42537 }, -- Gladiator's Grimoire
				{ 16, 42531 }, -- Gladiator's Reprieve
			},
		},
		{
			name = AL["Weapons"].." - "..ALIL["Shields"],
			[SET1_DIFF] = {
				{ 1, 42556 }, -- Gladiator's Shield Wall
				{ 16, 42568 }, -- Gladiator's Redoubt
				{ 17, 42557 }, -- Gladiator's Barrier
			},
			[SET2_DIFF] = {
				{ 1, 42558 }, -- Gladiator's Shield Wall
				{ 16, 42569 }, -- Gladiator's Redoubt
				{ 17, 42563 }, -- Gladiator's Barrier
			},
			[SET3_DIFF] = {
				{ 1, 42559 }, -- Gladiator's Shield Wall
				{ 16, 42570 }, -- Gladiator's Redoubt
				{ 17, 42564 }, -- Gladiator's Barrier
			},
		},
		{
			name = ALIL["Cloak"],
			[SET2_DIFF] = {
				{ 1, 42061 }, -- Gladiator's Cloak of Victory
				{ 2, 42060 }, -- Gladiator's Cloak of Triumph
				{ 16, 42057 }, -- Gladiator's Cloak of Ascendancy
				{ 17, 42056 }, -- Gladiator's Cloak of Subjugation
				{ 18, 42055 }, -- Gladiator's Cloak of Dominance
				{ 20, 42059 }, -- Gladiator's Cloak of Deliverance
				{ 21, 42058 }, -- Gladiator's Cloak of Salvation
			},
			[SET3_DIFF] = {
				{ 1, 42068 }, -- Gladiator's Cloak of Victory
				{ 2, 42067 }, -- Gladiator's Cloak of Triumph
				{ 16, 42064 }, -- Gladiator's Cloak of Ascendancy
				{ 17, 42063 }, -- Gladiator's Cloak of Subjugation
				{ 18, 42062 }, -- Gladiator's Cloak of Dominance
				{ 20, 42066 }, -- Gladiator's Cloak of Deliverance
				{ 21, 42065 }, -- Gladiator's Cloak of Salvation
			},
		},
		{
			name = ALIL["Relic"],
			[SET1_DIFF] = {
				{ 1, 42575 }, -- Gladiator's Idol of Steadfastness
				{ 2, 42574 }, -- Gladiator's Idol of Resolve
				{ 3, 42576 }, -- Gladiator's Idol of Tenacity
				{ 5, 42612 }, -- Gladiator's Libram of Justice
				{ 6, 42611 }, -- Gladiator's Libram of Fortitude
				{ 16, 42595 }, -- Gladiator's Totem of the Third Wind
				{ 17, 42594 }, -- Gladiator's Totem of Survival
				{ 18, 42593 }, -- Gladiator's Totem of Indomitability
				{ 20, 42618 }, -- Gladiator's Sigil of Strife
			},
			[SET2_DIFF] = {
				{ 1, 42582 }, -- Gladiator's Idol of Steadfastness
				{ 2, 42587 }, -- Gladiator's Idol of Resolve
				{ 3, 42577 }, -- Gladiator's Idol of Tenacity
				{ 5, 42613 }, -- Gladiator's Libram of Justice
				{ 6, 42851 }, -- Gladiator's Libram of Fortitude
				{ 16, 42596 }, -- Gladiator's Totem of the Third Wind
				{ 17, 42601 }, -- Gladiator's Totem of Survival
				{ 18, 42606 }, -- Gladiator's Totem of Indomitability
				{ 20, 42619 }, -- Gladiator's Sigil of Strife
			},
			[SET3_DIFF] = {
				{ 1, 42583 }, -- Gladiator's Idol of Steadfastness
				{ 2, 42588 }, -- Gladiator's Idol of Resolve
				{ 3, 42578 }, -- Gladiator's Idol of Tenacity
				{ 5, 42614 }, -- Gladiator's Libram of Justice
				{ 6, 42852 }, -- Gladiator's Libram of Fortitude
				{ 16, 42597 }, -- Gladiator's Totem of the Third Wind
				{ 17, 42602 }, -- Gladiator's Totem of Survival
				{ 18, 42607 }, -- Gladiator's Totem of Indomitability
				{ 20, 42620 }, -- Gladiator's Sigil of Strife
			},
		},
		{
			name = ALIL["Neck"],
			[SET2_DIFF] = {
				{ 1, 42021 }, -- Gladiator's Pendant of Victory
				{ 2, 42020 }, -- Gladiator's Pendant of Triumph
				{ 16, 42024 }, -- Gladiator's Pendant of Ascendancy
				{ 17, 42023 }, -- Gladiator's Pendant of Subjugation
				{ 18, 42022 }, -- Gladiator's Pendant of Dominance
				{ 20, 42025 }, -- Gladiator's Pendant of Deliverance
				{ 21, 42026 }, -- Gladiator's Pendant of Salvation
			},
			[SET3_DIFF] = {
				{ 1, 42028 }, -- Gladiator's Pendant of Victory
				{ 2, 42027 }, -- Gladiator's Pendant of Triumph
				{ 16, 42030 }, -- Gladiator's Pendant of Ascendancy
				{ 17, 42031 }, -- Gladiator's Pendant of Subjugation
				{ 18, 42029 }, -- Gladiator's Pendant of Dominance
				{ 20, 42032 }, -- Gladiator's Pendant of Deliverance
				{ 21, 42033 }, -- Gladiator's Pendant of Salvation
			},
		},
		{
			name = ALIL["Finger"],
			[SET2_DIFF] = {
				{ 1, 42112 }, -- Gladiator's Band of Triumph
				{ 16, 42110 }, -- Gladiator's Band of Dominance
			},
			[SET3_DIFF] = {
				{ 1, 42115 }, -- Gladiator's Band of Victory
				{ 16, 42114 }, -- Gladiator's Band of Ascendancy
			},
		},
		{
			name = format(AL["Non Set '%s'"], ALIL["Cloth"]),
			[NORMAL_DIFF] = {
				{ 1, 41884 }, -- Deadly Gladiator's Treads of Salvation
				{ 2, 41880 }, -- Deadly Gladiator's Cord of Salvation
				{ 3, 41892 }, -- Deadly Gladiator's Cuffs of Salvation
				{ 5, 41902 }, -- Deadly Gladiator's Treads of Dominance
				{ 6, 41897 }, -- Deadly Gladiator's Cord of Dominance
				{ 7, 41908 }, -- Deadly Gladiator's Cuffs of Dominance
				{ 16, 41879 }, -- Hateful Gladiator's Slippers of Salvation
				{ 17, 41877 }, -- Hateful Gladiator's Cord of Salvation
				{ 18, 41878 }, -- Hateful Gladiator's Cuffs of Salvation
				{ 20, 41901 }, -- Hateful Gladiator's Slippers of Dominance
				{ 21, 41896 }, -- Hateful Gladiator's Cord of Dominance
				{ 22, 41907 }, -- Hateful Gladiator's Cuffs of Dominance
			},
		},
		{
			name = format(AL["Non Set '%s'"], ALIL["Leather"]),
			[NORMAL_DIFF] = {
				{ 1, 41331 },  -- Hateful Gladiator's Boots of Salvation
				{ 2, 41330 },  -- Hateful Gladiator's Belt of Salvation, Waist
				{ 3, 41332 },  -- Hateful Gladiator's Armwraps of Salvation
				{ 5, 41633 },  -- Hateful Gladiator's Boots of Dominance
				{ 6, 41628 },  -- Hateful Gladiator's Belt of Dominance, Waist
				{ 7, 41638 }, -- Hateful Gladiator's Armwraps of Dominance
				{ 9, 41828 },  -- Hateful Gladiator's Boots of Triumph
				{ 10, 41827 },  -- Hateful Gladiator's Belt of Triumph, Waist
				{ 11, 41830 }, -- Hateful Gladiator's Armwraps of Triumph
				{ 16, 41620 }, -- Hateful Deadly Gladiator's Boots of Salvation
				{ 17, 41616 }, -- Hateful Deadly Gladiator's Belt of Salvation, Waist
				{ 18, 41624 }, -- Hateful Deadly Gladiator's Armwraps of Salvation
				{ 20, 41634 }, -- Hateful Deadly Gladiator's Boots of Dominance
				{ 21, 41629 }, -- Hateful Deadly Gladiator's Belt of Dominance, Waist
				{ 22, 41639 }, -- Hateful Deadly Gladiator's Armwraps of Dominance
				{ 24, 41835 }, -- Hateful Deadly Gladiator's Boots of Triumph
				{ 25, 41831 }, -- Hateful Deadly Gladiator's Belt of Triumph, Waist
				{ 26, 41839 }, -- Hateful Deadly Gladiator's Armwraps of Triumph
			},
		},
		{
			name = format(AL["Non Set '%s'"], ALIL["Mail"]),
			[NORMAL_DIFF] = {
				{ 1, 41049 }, -- Hateful Gladiator's Sabatons of Salvation
				{ 2, 41050 }, -- Hateful Gladiator's Waistguard of Salvation
				{ 3, 41047 }, -- Hateful Gladiator's Wristguards of Salvation
				{ 5, 41073 }, -- Hateful Gladiator's Sabatons of Dominance
				{ 6, 41068 }, -- Hateful Gladiator's Waistguard of Dominance
				{ 7, 41063 }, -- Hateful Gladiator's Wristguards of Dominance
				{ 9, 41228 }, -- Hateful Gladiator's Sabatons of Triumph
				{ 10, 41233 }, -- Hateful Gladiator's Waistguard of Triumph
				{ 11, 41223 }, -- Hateful Gladiator's Wristguards of Triumph
				{ 16, 41054 }, -- Deadly Gladiator's Sabatons of Salvation
				{ 17, 41048 }, -- Deadly Gladiator's Waistguard of Salvation
				{ 18, 41059 }, -- Deadly Gladiator's Wristguards of Salvation
				{ 20, 41074 }, -- Deadly Gladiator's Sabatons of Dominance
				{ 21, 41069 }, -- Deadly Gladiator's Waistguard of Dominance
				{ 22, 41064 }, -- Deadly Gladiator's Wristguards of Dominance
				{ 24, 41229 }, -- Deadly Gladiator's Sabatons of Triumph
				{ 25, 41234 }, -- Deadly Gladiator's Waistguard of Triumph
				{ 26, 41224 }, -- Deadly Gladiator's Wristguards of Triumph
			},
		},
		{
			name = format(AL["Non Set '%s'"], ALIL["Plate"]),
			[NORMAL_DIFF] = {
				{ 1, 40878 }, -- Hateful Gladiator's Greaves of Triumph
				{ 2, 40877 }, -- Hateful Gladiator's Girdle of Triumph
				{ 3, 40887 }, -- Hateful Gladiator's Bracers of Triumph
				{ 5, 40973 }, -- Hateful Gladiator's Greaves of Salvation
				{ 6, 40966 }, -- Hateful Gladiator's Girdle of Salvation
				{ 7, 40972 }, -- Hateful Gladiator's Bracers of Salvation
				{ 16, 40880 }, -- Deadly Gladiator's Greaves of Triumph
				{ 17, 40879 }, -- Deadly Gladiator's Girdle of Triumph
				{ 18, 40888 }, -- Deadly Gladiator's Bracers of Triumph
				{ 20, 40975 }, -- Deadly Gladiator's Greaves of Salvation
				{ 21, 40974 }, -- Deadly Gladiator's Girdle of Salvation
				{ 22, 40982 }, -- Deadly Gladiator's Bracers of Salvation
			},
		},
		{
			name = AL["Gladiator Mount"],
			ExtraList = true,
			[NORMAL_DIFF] = {
				{ 1,  46708 }, -- Deadly Gladiator's Frost Wyrm
			}
		}
	}
}
