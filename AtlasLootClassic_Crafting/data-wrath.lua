-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)
local select = _G.select
local string = _G.string
local format = string.format

-- WoW
local RAID_CLASS_COLORS = _G["RAID_CLASS_COLORS"]

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local addonname, private = ...
local AtlasLoot = _G.AtlasLoot
if AtlasLoot:GameVersion_LT(AtlasLoot.WRATH_VERSION_NUM) then return end
local data = AtlasLoot.ItemDB:Add(addonname, 1, AtlasLoot.WRATH_VERSION_NUM)

local GetColorSkill = AtlasLoot.Data.Profession.GetColorSkillRankNoSpell

local AL = AtlasLoot.Locales
local ALIL = AtlasLoot.IngameLocales

local NORMAL_DIFF = data:AddDifficulty(AL["Normal"], "n", 1, nil, true)
local LEATHER_DIFF = data:AddDifficulty(ALIL["Leather"], "leather", 0)
local MAIL_DIFF = data:AddDifficulty(ALIL["Mail"], "mail", 0)
local PLATE_DIFF = data:AddDifficulty(ALIL["Plate"], "plate", 0)

local NORMAL_ITTYPE = data:AddItemTableType("Item", "Item")
local PROF_ITTYPE = data:AddItemTableType("Profession", "Item")
local SET_ITTYPE = data:AddItemTableType("Set", "Item")

local QUEST_EXTRA_ITTYPE = data:AddExtraItemTableType("Quest")
local PRICE_EXTRA_ITTYPE = data:AddExtraItemTableType("Price")

local PROF_CONTENT = data:AddContentType(ALIL["Professions"], ATLASLOOT_PRIMPROFESSION_COLOR)
local PROF_GATH_CONTENT = data:AddContentType(ALIL["Gathering Professions"], ATLASLOOT_PRIMPROFESSION_COLOR)
local PROF_SEC_CONTENT = data:AddContentType(AL["Secondary Professions"], ATLASLOOT_SECPROFESSION_COLOR)
local PROF_CLASS_CONTENT = data:AddContentType(AL["Class Professions"], ATLASLOOT_CLASSPROFESSION_COLOR)

local GEM_FORMAT1 = ALIL["Gems"].." - %s"
local GEM_FORMAT2 = ALIL["Gems"].." - %s & %s"

data["AlchemyWrath"] = {
	name = ALIL["Alchemy"],
	ContentType = PROF_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = private.ALCHEMY_LINK,
	items = {
		{
			name = AL["Flasks"],
			[NORMAL_DIFF] = {
				{ 1, 53903 },	-- Flask of Endless Rage
				{ 2, 54213 },	-- Flask of Pure Mojo
				{ 3, 53902 },	-- Flask of Stoneblood
				{ 4, 53901 },	-- Flask of the Frost Wyrm
				{ 5, 53899 },	-- Lesser Flask of Toughness
			},
		},
		{
			name = AL["Transmutes"],
			[NORMAL_DIFF] = {
				{ 1, 66658 },	-- Transmute: Ametrine
				{ 2, 66662 },	-- Transmute: Dreadstone
				{ 3, 66664 },	-- Transmute: Eye of Zul
				{ 4, 66660 },	-- Transmute: King's Amber
				{ 5, 66663 },	-- Transmute: Majestic Zircon
				{ 6, 66659 },	-- Transmute: Cardinal Ruby
				{ 8, 57425 },	-- Transmute: Skyflare Diamond
				{ 9, 57427 },	-- Transmute: Earthsiege Diamond
				{ 11, 60350 },	-- Transmute: Titanium
				{ 16, 53777 },	-- Transmute: Eternal Air to Earth
				{ 17, 53776 },	-- Transmute: Eternal Air to Water
				{ 18, 53781 },	-- Transmute: Eternal Earth to Air
				{ 19, 53782 },	-- Transmute: Eternal Earth to Shadow
				{ 20, 53775 },	-- Transmute: Eternal Fire to Life
				{ 21, 53774 },	-- Transmute: Eternal Fire to Water
				{ 22, 53773 },	-- Transmute: Eternal Life to Fire
				{ 23, 53771 },	-- Transmute: Eternal Life to Shadow
				{ 24, 53779 },	-- Transmute: Eternal Shadow to Earth
				{ 25, 53780 },	-- Transmute: Eternal Shadow to Life
				{ 26, 53783 },	-- Transmute: Eternal Water to Air
				{ 27, 53784 },	-- Transmute: Eternal Water to Fire
			},
		},
		{
			name = AL["Healing/Mana Potions"],
			[NORMAL_DIFF] = {
			{ 1, 53904 },	-- Powerful Rejuvenation Potion
			{ 2, 53895 },	-- Crazy Alchemist's Potion

			{ 4, 58871 },	-- Endless Healing Potion
			{ 5, 53836 },	-- Runic Healing Potion
			{ 6, 53838 },	-- Resurgent Healing Potion

			{ 16, 53900 },	-- Potion of Nightmares

			{ 19, 58868 },	-- Endless Mana Potion
			{ 20, 53837 },	-- Runic Mana Potion
			{ 21, 53839 },	-- Icy Mana Potion
			},
		},
		{
			name = AL["Protection Potions"],
			[NORMAL_DIFF] = {
				{ 1, 53936 },	-- Mighty Arcane Protection Potion
				{ 2, 53939 },	-- Mighty Fire Protection Potion
				{ 3, 53937 },	-- Mighty Frost Protection Potion
				{ 4, 53942 },	-- Mighty Nature Protection Potion
				{ 5, 53938 },	-- Mighty Shadow Protection Potion
			},
		},
		{
			name = AL["Util Potions"],
			[NORMAL_DIFF] = {
				{ 1, 54221 },	-- Potion of Speed
				{ 2, 54222 },	-- Potion of Wild Magic
				{ 3, 53905 },	-- Indestructible Potion
			},
		},
		{
			name = AL["Elixirs"],
			[NORMAL_DIFF] = {
				{ 1, 60354 },	-- Elixir of Accuracy
				{ 2, 60365 },	-- Elixir of Armor Piercing
				{ 3, 60355 },	-- Elixir of Deadly Strikes
				{ 4, 60357 },	-- Elixir of Expertise
				{ 5, 60366 },	-- Elixir of Lightning Speed
				{ 6, 56519 },	-- Elixir of Mighty Mageblood
				{ 7, 53840 },	-- Elixir of Mighty Agility
				{ 8, 54218 },	-- Elixir of Mighty Strength
				{ 9, 53847 },	-- Elixir of Spirit
				{ 10, 53848 },	-- Guru's Elixir
				{ 11, 53842 },	-- Spellpower Elixir
				{ 12, 53841 },	-- Wrath Elixir
				{ 16, 60356 },	-- Elixir of Mighty Defense
				{ 17, 54220 },	-- Elixir of Protection
				{ 18, 62410 },	-- Elixir of Water Walking
				{ 19, 60367 },	-- Elixir of Mighty Thoughts
				{ 20, 53898 },	-- Elixir of Mighty Fortitude
			},
		},
		{
			name = AL["Stones"],
			[NORMAL_DIFF] = {
				{ 1, 60403 },	-- Indestructible Alchemist Stone
				{ 2, 60396 },	-- Mercurial Alchemist Stone
				{ 3, 60405 },	-- Mighty Alchemist Stone
			},
		},
		{
			name = AL["Misc"],
			[NORMAL_DIFF] = {
				{ 1, 62409 },	-- Ethereal Oil
				{ 2, 53812 },	-- Pygmy Oil
			},
		}
	},
}

data["BlacksmithingWrath"] = {
	name = ALIL["Blacksmithing"],
	ContentType = PROF_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = private.BLACKSMITHING_LINK,
	items = {
		{ -- Daggers
			name = AL["Weapons"].." - "..ALIL["Daggers"],
			[NORMAL_DIFF] = {
				{ 1, 56234 },	-- Titansteel Shanker
				{ 2, 55181 },	-- Saronite Shiv
				{ 3, 55179 },	-- Saronite Ambusher
				{ 16, 63182 },	-- Titansteel Spellblade
			}
		},
		{ -- Axes
			name = AL["Weapons"].." - "..AL["Axes"],
			[NORMAL_DIFF] = {
				{ 1, "INV_sword_04", nil, ALIL["One-Handed Axes"] },
				{ 2, 55204 },	-- Notched Cobalt War Axe
				{ 16, "INV_sword_04", nil, ALIL["Two-Handed Axes"] },
				{ 17, 55174 },	-- Honed Cobalt Cleaver
			}
		},
		{ -- Maces
			name = AL["Weapons"].." - "..AL["Maces"],
			[NORMAL_DIFF] = {
				{ 1, "INV_sword_04", nil, ALIL["One-Handed Maces"] },
				{ 2, 55370 },	-- Titansteel Bonecrusher
				{ 3, 55371 },	-- Titansteel Guardian
				{ 4, 56280 },	-- Cudgel of Saronite Justice
				{ 5, 55182 },	-- Furious Saronite Beatstick
				{ 6, 55201 },	-- Cobalt Tenderizer
				{ 16, "INV_sword_04", nil, ALIL["Two-Handed Maces"] },
				{ 17, 55369 },	-- Titansteel Destroyer
				{ 18, 55185 },	-- Saronite Mindcrusher
			}
		},
		{ -- Swords
			name = AL["Weapons"].." - "..AL["Swords"],
			[NORMAL_DIFF] = {
				{ 1, "INV_sword_04", nil, ALIL["One-Handed Swords"] },
				{ 2, 55183 },	-- Corroded Saronite Edge
				{ 3, 55184 },	-- Corroded Saronite Woundbringer
				{ 4, 59442 },	-- Saronite Spellblade
				{ 5, 55177 },	-- Savage Cobalt Slicer
				{ 6, 55200 },	-- Sturdy Cobalt Quickblade
				{ 16, "INV_sword_06", nil, ALIL["Two-Handed Swords"] },
				{ 17, 55203 },	-- Forged Cobalt Claymore
			}
		},
		{ -- Shield
			name = AL["Weapons"].." - "..ALIL["Shield"],
			[NORMAL_DIFF] = {
				{ 1, 56400 },	-- Titansteel Shield Wall
				{ 2, 55014 },	-- Saronite Bulwark
				{ 3, 54557 },	-- Saronite Defender
				{ 4, 54550 },	-- Cobalt Triangle Shield
				{ 16, 55013 },	-- Saronite Protector
			}
		},
		{ -- Head
			name = AL["Armor"].." - "..ALIL["Head"],
			[PLATE_DIFF] = {
				{ 1, 55374 },	-- Brilliant Titansteel Helm
				{ 2, 55372 },	-- Spiked Titansteel Helm
				{ 3, 55373 },	-- Tempered Titansteel Helm
				{ 4,55302 },	-- Helm of Command
				{ 5, 56556 },	-- Ornate Saronite Skullshield
				{ 6, 55312 },	-- Savage Saronite Skullshield
				{ 7, 59441 },	-- Brilliant Saronite Helm
				{ 8, 54555 },	-- Tempered Saronite Helm
				{ 9, 54949 },	-- Horned Cobalt Helm
				{ 10, 54979 },	-- Reinforced Cobalt Helm
				{ 11, 54917 },	-- Spiked Cobalt Helm
				{ 12, 52571 },	-- Cobalt Helm
			},
		},
		{ -- Shoulder
			name = AL["Armor"].." - "..ALIL["Shoulder"],
			[PLATE_DIFF] = {
				{ 1, 56550 },	-- Ornate Saronite Pauldrons
				{ 2, 55306 },	-- Savage Saronite Pauldrons
				{ 3, 59440 },	-- Brilliant Saronite Pauldrons
				{ 4, 54556 },	-- Tempered Saronite Shoulders
				{ 5, 54941 },	-- Spiked Cobalt Shoulders
				{ 6, 54978 },	-- Reinforced Cobalt Shoulders
				{ 7, 52572 },	-- Cobalt Shoulders
			},
		},
		{ -- Chest
			name = AL["Armor"].." - "..ALIL["Chest"],
			[PLATE_DIFF] = {
				{ 1, [ATLASLOOT_IT_ALLIANCE] = { 67091 }, [ATLASLOOT_IT_HORDE] = { 67130 } },	-- Breastplate of the White Knight
				{ 2, [ATLASLOOT_IT_ALLIANCE] = { 67095 }, [ATLASLOOT_IT_HORDE] = { 67134 } },	-- Sunforged Breastplate
				{ 3, [ATLASLOOT_IT_ALLIANCE] = { 67094 }, [ATLASLOOT_IT_HORDE] = { 67133 } },	-- Titanium Spikeguards
				{ 4, 55311 },	-- Savage Saronite Hauberk
				{ 5, 55058 },	-- Brilliant Saronite Breastplate
				{ 6, 55186 },	-- Chestplate of Conquest
				{ 7, 54553 },	-- Tempered Saronite Breastplate
				{ 8, 54944 },	-- Spiked Cobalt Chestpiece
				{ 9, 54981 },	-- Reinforced Cobalt Chestpiece
				{ 10, 52570 },	-- Cobalt Chestpiece
			},
		},
		{ -- Feet
			name = AL["Armor"].." - "..ALIL["Feet"],
			[PLATE_DIFF] = {
				{ 1, 70568 },	-- Boots of Kingly Upheaval
				{ 2, 70566 },	-- Hellfrozen Bonegrinders
				{ 3, 70563 },	-- Protectors of Life
				{ 4, 63188 },	-- Battlelord's Plate Boots
				{ 5, 63192 },	-- Spiked Deathdealers
				{ 6, 63190 },	-- Treads of Destiny
				{ 7, 55377 },	-- Brilliant Titansteel Treads
				{ 8, 55375 },	-- Spiked Titansteel Treads
				{ 9, 55376 },	-- Tempered Titansteel Treads
				{ 10, 61010 },	-- Icebane Treads
				{ 11, 56552 },	-- Ornate Saronite Walkers
				{ 12, 55308 },	-- Savage Saronite Walkers
				{ 13, 55057 },	-- Brilliant Saronite Boots
				{ 14, 54552 },	-- Tempered Saronite Boots
				{ 15, 54918 },	-- Spiked Cobalt Boots
				{ 16, 52569 },	-- Cobalt Boots
			},
		},
		{ -- Hand
			name = AL["Armor"].." - "..ALIL["Hand"],
			[PLATE_DIFF] = {
				{ 1, 55301 },	-- Daunting Handguards
				{ 2, 56553 },	-- Ornate Saronite Gauntlets
				{ 3, 55300 },	-- Righteous Gauntlets
				{ 4, 55309 },	-- Savage Saronite Gauntlets
				{ 5, 55015 },	-- Tempered Saronite Gauntlets
				{ 6, 55056 },	-- Brilliant Saronite Gauntlets
				{ 7, 54945 },	-- Spiked Cobalt Gauntlets
				{ 8, 55835 },	-- Cobalt Gauntlets
			},
		},
		{ -- Legs
			name = AL["Armor"].." - "..ALIL["Legs"],
			[PLATE_DIFF] = {
				{ 1, 70565 },	-- Legplates of Painful Death
				{ 2, 70567 },	-- Pillars of Might
				{ 3, 70562 },	-- Puresteel Legplates
				{ 4,55303 },	-- Daunting Legplates
				{ 5, 56554 },	-- Ornate Saronite Legplates
				{ 6, 55304 },	-- Righteous Greaves
				{ 7, 55310 },	-- Savage Saronite Legplates
				{ 8, 55187 },	-- Legplates of Conquest
				{ 9, 55055 },	-- Brilliant Saronite Legplates
				{ 10, 54554 },	-- Tempered Saronite Legplates
				{ 11, 54947 },	-- Spiked Cobalt Legplates
				{ 12, 54980 },	-- Reinforced Cobalt Legplates
				{ 13, 52567 },	-- Cobalt Legplates
			},
		},
		{ -- Waist
			name = AL["Armor"].." - "..ALIL["Waist"],
			[PLATE_DIFF] = {
				{ 1, 63187 },	-- Belt of the Titans
				{ 2, 63191 },	-- Indestructible Plate Girdle
				{ 3, 63189 },	-- Plate Girdle of Righteousness
				{ 4, 61009 },	-- Icebane Girdle
				{ 5, 56551 },	-- Ornate Saronite Waistguard
				{ 6, 55307 },	-- Savage Saronite Waistguard
				{ 7, 59436 },	-- Brilliant Saronite Belt
				{ 8, 54551 },	-- Tempered Saronite Belt
				{ 9, 54946 },	-- Spiked Cobalt Belt
				{ 10, 52568 },	-- Cobalt Belt
			},
		},
		{ -- Wrist
			name = AL["Armor"].." - "..ALIL["Wrist"],
			[PLATE_DIFF] = {
				{ 1, [ATLASLOOT_IT_ALLIANCE] = { 67092 }, [ATLASLOOT_IT_HORDE] = { 67131 } },	-- Saronite Swordbreakers
				{ 2, [ATLASLOOT_IT_ALLIANCE] = { 67096 }, [ATLASLOOT_IT_HORDE] = { 67135 } },	-- Sunforged Bracers
				{ 3, [ATLASLOOT_IT_ALLIANCE] = { 67094 }, [ATLASLOOT_IT_HORDE] = { 67133 } },	-- Titanium Spikeguard
				{ 4, 56549 },	-- Ornate Saronite Bracers
				{ 5, 55305 },	-- Savage Saronite Bracers
				{ 6, 55298 },	-- Vengeance Bindings
				{ 7, 55017 },	-- Tempered Saronite Bracers
				{ 8, 59438 },	-- Brilliant Saronite Bracers
				{ 9, 54948 },	-- Spiked Cobalt Bracers
				{ 10, 55834 },	-- Cobalt Bracers
			},
		},
		{ -- Sets
			name = AL["Sets"],
			ExtraList = true,
			TableType = SET_ITTYPE,
			[NORMAL_DIFF] = {
				{ 1, 814 }, -- Ornate Saronite Battlegear
				{ 2, 816 }, -- Savage Saronite Battlegear
			},
		},
	}
}

data["EnchantingWrath"] = {
	name = ALIL["Enchanting"],
	ContentType = PROF_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = private.ENCHANTING_LINK,
	items = {
		{
			name = ALIL["Weapon"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 64441 },	-- Enchant Weapon - Blade Ward
				{ 2, 64579 },	-- Enchant Weapon - Blood Draining
				{ 3, 59619 },	-- Enchant Weapon - Accuracy
				{ 4, 59625 },	-- Enchant Weapon - Black Magic
				{ 5, 59621 },	-- Enchant Weapon - Berserking
				{ 6, 60714 },	-- Enchant Weapon - Mighty Spellpower
				{ 7, 60707 },	-- Enchant Weapon - Superior Potency
				{ 8, 44621 },	-- Enchant Weapon - Giant Slayer
				{ 9, 44524 },	-- Enchant Weapon - Icebreaker
				{ 10, 44576 },	-- Enchant Weapon - Lifeward
				{ 11, 44633 },	-- Enchant Weapon - Exceptional Agility
				{ 12, 44510 },	-- Enchant Weapon - Exceptional Spirit
				{ 13, 44629 },	-- Enchant Weapon - Exceptional Spellpower
				{ 14, 60621 },	-- Enchant Weapon - Greater Potency
			}
		},
		{
			name = ALIL["2H Weapon"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 60691 },	-- Enchant 2H Weapon - Massacre
				{ 2, 44595 },	-- Enchant 2H Weapon - Scourgebane
				{ 3, 44630 },	-- Enchant 2H Weapon - Greater Savagery
				{ 16, 62948 },	-- Enchant Staff - Greater Spellpower
				{ 17, 62959 },	-- Enchant Staff - Spellpower
			}
		},
		{
			name = ALIL["Cloak"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 44631 },	-- Enchant Cloak - Shadow Armor
				{ 2, 47899 },	-- Enchant Cloak - Wisdom
				{ 3, 44591 },	-- Enchant Cloak - Superior Dodge
				{ 4, 47898 },	-- Enchant Cloak - Greater Speed
				{ 5, 47672 },	-- Enchant Cloak - Mighty Stamina
				{ 6, 60663 },	-- Enchant Cloak - Major Agility
				{ 7, 44500 },	-- Enchant Cloak - Superior Agility
				{ 8, 44582 },	-- Enchant Cloak - Minor Power
				{ 9, 60609 },	-- Enchant Cloak - Speed
			}
		},
		{
			name = ALIL["Chest"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 60692 },	-- Enchant Chest - Powerful Stats
				{ 2, 47900 },	-- Enchant Chest - Super Health
				{ 3, 44509 },	-- Enchant Chest - Greater Mana Restoration
				{ 4, 44588 },	-- Enchant Chest - Exceptional Resilience
				{ 5, 47766 },	-- Enchant Chest - Greater Dodge
				{ 6, 44492 },	-- Enchant Chest - Mighty Health
				{ 7, 44623 },	-- Enchant Chest - Super Stats
				{ 8, 27958 },	-- Enchant Chest - Exceptional Mana
			}
		},
		{
			name = ALIL["Feet"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 60763 },	-- Enchant Boots - Greater Assault
				{ 2, 47901 },	-- Enchant Boots - Tuskarr's Vitality
				{ 3, 44508 },	-- Enchant Boots - Greater Spirit
				{ 4, 44589 },	-- Enchant Boots - Superior Agility
				{ 5, 44584 },	-- Enchant Boots - Greater Vitality
				{ 6, 44528 },	-- Enchant Boots - Greater Fortitude
				{ 7, 60623 },	-- Enchant Boots - Icewalker
				{ 8, 60606 },	-- Enchant Boots - Assault
			}
		},
		{
			name = ALIL["Hand"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 44625 },	-- Enchant Gloves - Armsman
				{ 2, 60668 },	-- Enchant Gloves - Crusher
				{ 3, 44513 },	-- Enchant Gloves - Greater Assault
				{ 4, 44529 },	-- Enchant Gloves - Major Agility
				{ 5, 44488 },	-- Enchant Gloves - Precision
				{ 6, 44484 },	-- Enchant Gloves - Haste
				{ 7, 71692 },	-- Enchant Gloves - Angler
				{ 8, 44506 },	-- Enchant Gloves - Gatherer
				{ 9, 44592 },	-- Enchant Gloves - Exceptional Spellpower
			}
		},
		{
			name = ALIL["Shield"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 44489 },	-- Enchant Shield - Dodge
				{ 2, 60653 },	-- Enchant Shield - Greater Intellect
			}
		},
		{
			name = ALIL["Wrist"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 62256 },	-- Enchant Bracer - Major Stamina
				{ 2, 60767 },	-- Enchant Bracer - Superior Spellpower
				{ 3, 44575 },	-- Enchant Bracer - Greater Assault
				{ 4, 44598 },	-- Enchant Bracer - Haste
				{ 5, 44616 },	-- Enchant Bracer - Greater Stats
				{ 6, 44593 },	-- Enchant Bracer - Major Spirit
				{ 7, 44635 },	-- Enchant Bracer - Greater Spellpower
				{ 8, 44555 },	-- Enchant Bracer - Exceptional Intellect
				{ 9, 60616 },	-- Enchant Bracer - Assault
			}
		},
		{
			name = AL["Ring"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 44636 },	-- Enchant Ring - Greater Spellpower
				{ 2, 44645 },	-- Enchant Ring - Assault
				{ 3, 59636 },	-- Enchant Ring - Stamina
			}
		},
		{
			name = AL["Misc"],
			[NORMAL_DIFF] = {
				{ 1, 69412 },	-- Abyssal Shatter
			}
		},
	}
}

data["EngineeringWrath"] = {
	name = ALIL["Engineering"],
	ContentType = PROF_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = private.ENGINEERING_LINK,
	items = {
		{
			name = AL["Armor"].." - "..ALIL["Head"].." - "..ALIL["Cloth"],
			[NORMAL_DIFF] = {
				{ 1, 56484 },	-- Visage Liquification Goggles
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Head"].." - "..ALIL["Leather"],
			[NORMAL_DIFF] = {
				{ 1, 56486 },	-- Greensight Gogs
				{ 2, 56481 },	-- Weakness Spectralizers
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Head"].." - "..ALIL["Mail"],
			[NORMAL_DIFF] = {
				{ 1, 56487 },	-- Electroflux Sight Enhancers
				{ 2, 56574 },	-- Truesight Ice Blinders
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Head"].." - "..ALIL["Plate"],
			[NORMAL_DIFF] = {
				{ 1, 56480 },	-- Armored Titanium Goggles
				{ 2, 56483 },	-- Charged Titanium Specs
				{ 3, 62271 },	-- Unbreakable Healing Amplifiers
				{ 16, 61483 },	-- Mechanized Snow Goggles
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Trinket"],
			[NORMAL_DIFF] = {
				{ 1, 56469 },	-- Gnomish Lightning Generator
				{ 2, 56467 },	-- Noise Machine
				{ 3, 56466 },	-- Sonic Booster
			}
		},
		{
			name = ALIL["Weapon"].." - "..AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 56478 },	-- Heartseeker Scope
				{ 2, 56470 },	-- Sun Scope
				{ 3, 61471 },	-- Diamond-Cut Refractor Scope
			}
		},
		{
			name = AL["Weapons"].." - "..ALIL["Guns"],
			[NORMAL_DIFF] = {
				{ 1, 56479 },	-- Armor Plated Combat Shotgun
				{ 2, 60874 },	-- Nesingwary 4000
				{ 3, 54353 },	-- Mark "S" Boomstick
			}
		},
		{
			name = ALIL["Projectile"],
			[NORMAL_DIFF] = {
				{ 1, 72953 },	-- Iceblade Arrow
				{ 2, 56475 },	-- Saronite Razorheads
				{ 16, 72952 },	-- Shatter Rounds
				{ 17, 56474 },	-- Mammoth Cutters
			}
		},
		{
			name = ALIL["Parts"],
			[NORMAL_DIFF] = {
				{ 1, 56471 },	-- Froststeel Tube
				{ 2, 56464 },	-- Overcharged Capacitor
				{ 3, 56349 },	-- Handful of Cobalt Bolts
				{ 4, 53281 },	-- Volatile Blasting Trigger
			}
		},
		{
			name = ALIL["Explosives"],
			[NORMAL_DIFF] = {
				{ 1, 56514 },	-- Global Thermal Sapper Charge
				{ 3, 56463 },	-- Explosive Decoy
				{ 4, 56460 },	-- Cobalt Frag Bomb
				{ 16, 56468 },	-- Box of Bombs
				{ 17, "i44951" }
			}
		},
		{
			name = AL["Misc"],
			[NORMAL_DIFF] = {
				{ 1,   [ATLASLOOT_IT_ALLIANCE] = { 60867 }, [ATLASLOOT_IT_HORDE] = { 60866 } }, -- Mekgineer's Chopper / Mechano-Hog
				{ 3, 56476 },	-- Healing Injector Kit
				{ 4, 56477 },	-- Mana Injector Kit
				{ 6, 56461 },	-- Bladed Pickaxe
				{ 7, 56459 },	-- Hammer Pick
				{ 9, 55252 },	-- Scrapbot Construction Kit
				{ 11, 56462 },	-- Gnomish Army Knife
				{ 13, 67326 },	-- Goblin Beam Welder
				{ 16, 68067 },	-- Jeeves
				{ 18, 56472 },	-- MOLL-E
				{ 20, 67920 },	-- Wormhole Generator: Northrend
				{ 22, 30349 },	-- Titanium Toolbox
				{ 24, 56473 },	-- Gnomish X-Ray Specs
			}
		},
	}
}

data["TailoringWrath"] = {
	name = ALIL["Tailoring"],
	ContentType = PROF_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = private.TAILORING_LINK,
	items = {
		{
			name = AL["Armor"].." - "..ALIL["Cloak"],
			[NORMAL_DIFF] = {
				{ 1, 56017 },	-- Deathchill Cloak
				{ 2, 56016 },	-- Wispcloak
				{ 3, 64730 },	-- Cloak of Crimson Snow
				{ 4, 64729 },	-- Frostguard Drape
				{ 5, 56015 },	-- Cloak of Frozen Spirits
				{ 6, 56014 },	-- Cloak of the Moon
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Head"],
			[NORMAL_DIFF] = {
				{ 1, 56018 },	-- Hat of Wintry Doom
				{ 2, 59589 },	-- Frostsavage Cowl
				{ 3, 55919 },	-- Duskweave Cowl
				{ 4, 55907 },	-- Frostwoven Cowl
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Shoulder"],
			[NORMAL_DIFF] = {
				{ 1, 59584 },	-- Frostsavage Shoulders
				{ 2, 55910 },	-- Mystic Frostwoven Shoulders
				{ 3, 55923 },	-- Duskweave Shoulders
				{ 4, 55902 },	-- Frostwoven Shoulders
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Chest"],
			[NORMAL_DIFF] = {
				{ 1, [ATLASLOOT_IT_ALLIANCE] = { 67066 }, [ATLASLOOT_IT_HORDE] = { 67146 } },	-- Merlin's Robe
				{ 2, [ATLASLOOT_IT_ALLIANCE] = { 67064 }, [ATLASLOOT_IT_HORDE] = { 67144 } },	-- Royal Moonshroud Robe
				{ 3, 56026 },	-- Ebonweave Robe
				{ 4, 56024 },	-- Moonshroud Robe
				{ 5, 56028 },	-- Spellweave Robe
				{ 6, 60993 },	-- Glacial Robe
				{ 7, 59587 },	-- Frostsavage Robe
				{ 8, 55941 },	-- Black Duskweave Robe
				{ 9, 55911 },	-- Mystic Frostwoven Robe
				{ 10, 55921 },	-- Duskweave Robe
				{ 11, 55903 },	-- Frostwoven Robe
			},
		},
		{
			name = AL["Armor"].." - "..ALIL["Feet"],
			[NORMAL_DIFF] = {
				{ 1, 70551 },	-- Deathfrost Boots
				{ 2, 70553 },	-- Sandals of Consecration
				{ 3, 63206 },	-- Savior's Slippers
				{ 4, 63204 },	-- Spellslinger's Slippers
				{ 5, 60994 },	-- Glacial Slippers
				{ 6, 56023 },	-- Aurora Slippers
				{ 7, 59585 },	-- Frostsavage Boots
				{ 8, 56019 },	-- Silky Iceshard Boots
				{ 9, 55924 },	-- Duskweave Boots
				{ 10, 55906 },	-- Frostwoven Boots
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Hand"],
			[NORMAL_DIFF] = {
				{ 1, 56027 },	-- Ebonweave Gloves
				{ 2, 56025 },	-- Moonshroud Gloves
				{ 3, 56029 },	-- Spellweave Gloves
				{ 4, 59586 },	-- Frostsavage Gloves
				{ 5, 56022 },	-- Light Blessed Mittens
				{ 6, 55922 },	-- Duskweave Gloves
				{ 7, 55904 },	-- Frostwoven Gloves
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Legs"],
			[NORMAL_DIFF] = {
				{ 1, 70550 },	-- Leggings of Woven Death
				{ 2, 70552 },	-- Lightweave Leggings
				{ 3, 56021 },	-- Frostmoon Pants
				{ 4, 59588 },	-- Frostsavage Leggings
				{ 5, 55925 },	-- Black Duskweave Leggings
				{ 6, 55901 },	-- Duskweave Leggings
				{ 7, 56030 },	-- Frostwoven Leggings
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Waist"],
			[NORMAL_DIFF] = {
				{ 1, 63205 },	-- Cord of the White Dawn
				{ 2, 63203 },	-- Sash of Ancient Power
				{ 3, 60990 },	-- Glacial Waistband
				{ 4, 56020 },	-- Deep Frozen Cord
				{ 5, 59582 },	-- Frostsavage Belt
				{ 6, 55914 },	-- Duskweave Belt
				{ 7, 55908 },	-- Frostwoven Belt
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Wrist"],
			[NORMAL_DIFF] = {
				{ 1, [ATLASLOOT_IT_ALLIANCE] = { 67079 }, [ATLASLOOT_IT_HORDE] = { 67145 } },	-- Bejeweled Wizard's Bracers
				{ 2, [ATLASLOOT_IT_ALLIANCE] = { 67065 }, [ATLASLOOT_IT_HORDE] = { 67147 } },	-- Royal Moonshroud Bracers
				{ 3, 55943 },	-- Black Duskweave Wristwraps
				{ 4, 59583 },	-- Frostsavage Bracers
				{ 5, 55913 },	-- Mystic Frostwoven Wriststraps
				{ 6, 55920 },	-- Duskweave Wriststraps
				{ 7, 56031 },	-- Frostwoven Wriststraps
			}
		},
		{
			name = ALIL["Bag"],
			[NORMAL_DIFF] = {
				{ 1, 56005 },	-- Glacial Bag
				{ 2, 56007 },	-- Frostweave Bag
				{ 16, 63924 },	-- Emerald Bag
				{ 18, 56004 },	-- Abyssal Bag
				{ 20, 56006 },	-- Mysterious Bag
			}
		},
		{
			name = AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 56034 },	-- Master's Spellthread
				{ 2, 56010 },	-- Azure Spellthread
				{ 16, 56039 },	-- Sanctified Spellthread
				{ 17, 56008 },	-- Shining Spellthread
			}
		},
		{
			name = AL["Misc"],
			[NORMAL_DIFF] = {
				{ 1, 75597 },	-- Frosty Flying Carpet
				{ 2, 60971 },	-- Magnificent Flying Carpet
				{ 3, 60969 },	-- Flying Carpet
				{ 5, 56002 },	-- Ebonweave
				{ 6, 56001 },	-- Moonshroud
				{ 8, 55900 },	-- Bolt of Imbued Frostweave
				{ 9, 55899 },	-- Bolt of Frostweave
				{ 16, 55898 },	-- Frostweave Net
				{ 20, 56003 },	-- Spellweave
			}
		},
		{ -- Sets
			name = AL["Sets"],
			ExtraList = true,
			TableType = SET_ITTYPE,
			[NORMAL_DIFF] = {
				{ 1, 764 }, -- Duskweaver
				{ 2, 763 }, -- Frostwoven Power
			},
		},
	}
}

data["LeatherworkingWrath"] = {
	name = ALIL["Leatherworking"],
	ContentType = PROF_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = private.LEATHERWORKING_LINK,
	items = {
		{ -- Cloak
			name = AL["Armor"].." - "..ALIL["Cloak"],
			[NORMAL_DIFF] = {
				{ 1, 60637 },	-- Ice Striker's Cloak
				{ 2, 55199 },	-- Cloak of Tormented Skies
				{ 3, 60631 },	-- Cloak of Harsh Winds
			}
		},
		{ -- Chest
			name = AL["Armor"].." - "..ALIL["Chest"],
			[LEATHER_DIFF] = {
				{ 1, [ATLASLOOT_IT_ALLIANCE] = { 67086 }, [ATLASLOOT_IT_HORDE] = { 67142 } },	-- Knightbane Carapace
				{ 2, [ATLASLOOT_IT_ALLIANCE] = { 67084 }, [ATLASLOOT_IT_HORDE] = { 67140 } },	-- Lunar Eclipse Chestguard
				{ 3, 60996 },	-- Polar Vest
				{ 4, 60703 },	-- Eviscerator's Chestguard
				{ 5, 60718 },	-- Overcast Chestguard
				{ 6, 60669 },	-- Wildscale Breastplate
				{ 7, 51570 },	-- Dark Arctic Chestpiece
				{ 8, 60613 },	-- Dark Iceborne Chestguard
				{ 9, 50944 },	-- Arctic Chestpiece
				{ 10, 50938 },	-- Iceborne Chestguard
			},
			[MAIL_DIFF] = {
				{ 1, [ATLASLOOT_IT_ALLIANCE] = { 67082 }, [ATLASLOOT_IT_HORDE] = { 67138 } },	-- Crusader's Dragonscale Breastplate
				{ 2, [ATLASLOOT_IT_ALLIANCE] = { 67080 }, [ATLASLOOT_IT_HORDE] = { 67136 } },	-- Ensorcelled Nerubian Breastplate
				{ 3, 60756 },	-- Revenant's Breastplate
				{ 4, 60999 },	-- Icy Scale Chestguard
				{ 5, 60730 },	-- Swiftarrow Hauberk
				{ 6, 60747 },	-- Stormhide Hauberk
				{ 7, 60649 },	-- Razorstrike Breastplate
				{ 8, 60604 },	-- Dark Frostscale Breastplate
				{ 9, 60629 },	-- Dark Nerubian Chestpiece
				{ 10, 50950 },	-- Frostscale Chestguard
				{ 11, 50956 },	-- Nerubian Chestguard
			},
		},
		{ -- Feet
			name = AL["Armor"].." - "..ALIL["Feet"],
			[LEATHER_DIFF] = {
				{ 1, 70555 },	-- Blessed Cenarion Boots
				{ 2, 70557 },	-- Footpads of Impending Death
				{ 3, 63201 },	-- Boots of Wintry Endurance
				{ 4, 63199 },	-- Footpads of Silence
				{ 5, 60761 },	-- Earthgiving Boots
				{ 6, 60998 },	-- Polar Boots
				{ 7, 62176 },	-- Windripper Boots
				{ 8, 60712 },	-- Eviscerator's Treads
				{ 9, 60727 },	-- Overcast Boots
				{ 10, 60666 },	-- Jormscale Footpads
				{ 11, 51568 },	-- Black Chitinguard Boots
				{ 12, 60620 },	-- Bugsquashers
				{ 13, 50948 },	-- Arctic Boots
				{ 14, 50942 },	-- Iceborne Boots
			},
			[MAIL_DIFF] = {
				{ 1, 70559 },	-- Earthsoul Boots
				{ 2, 70561 },	-- Rock-Steady Treads
				{ 3, 63195 },	-- Boots of Living Scale
				{ 4, 63197 },	-- Lightning Grounded Boots
				{ 5, 60757 },	-- Revenant's Treads
				{ 6, 61002 },	-- Icy Scale Boots
				{ 7, 60737 },	-- Swiftarrow Boots
				{ 8, 60752 },	-- Stormhide Stompers
				{ 9, 60605 },	-- Dragonstompers
				{ 10, 60630 },	-- Scaled Icewalkers
				{ 11, 50954 },	-- Frostscale Boots
				{ 12, 50960 },	-- Nerubian Boots
			},
		},
		{ -- Hand
			name = AL["Armor"].." - "..ALIL["Hand"],
			[LEATHER_DIFF] = {
				{ 1, 60705 },	-- Eviscerator's Gauntlets
				{ 2, 60721 },	-- Overcast Handwraps
				{ 3, 60665 },	-- Seafoam Gauntlets
				{ 4, 50947 },	-- Arctic Gloves
				{ 5, 50941 },	-- Iceborne Gloves
			},
			[MAIL_DIFF] = {
				{ 1, 60732 },	-- Swiftarrow Gauntlets
				{ 2, 60749 },	-- Stormhide Grips
				{ 3, 50953 },	-- Frostscale Gloves
				{ 4, 50959 },	-- Nerubian Gloves
			},
		},
		{ -- Head
			name = AL["Armor"].." - "..ALIL["Head"],
			[LEATHER_DIFF] = {
				{ 1, 60697 },	-- Eviscerator's Facemask
				{ 2, 60715 },	-- Overcast Headguard
				{ 3, 51572 },	-- Arctic Helm
				{ 4, 60608 },	-- Iceborne Helm
			},
			[MAIL_DIFF] = {
				{ 1, 60728 },	-- Swiftarrow Helm
				{ 2, 60743 },	-- Stormhide Crown
				{ 3, 60655 },	-- Nightshock Hood
				{ 4, 60600 },	-- Frostscale Helm
				{ 5, 60624 },	-- Nerubian Helm
			},
		},
		{ -- Legs
			name = AL["Armor"].." - "..ALIL["Legs"],
			[LEATHER_DIFF] = {
				{ 1, 70556 },	-- Bladeborn Leggings
				{ 2, 70554 },	-- Legwraps of Unleashed Nature
				{ 3, 60760 },	-- Earthgiving Legguards
				{ 4, 62177 },	-- Windripper Leggings
				{ 5, 60711 },	-- Eviscerator's Legguards
				{ 6, 60725 },	-- Overcast Leggings
				{ 7, 60660 },	-- Leggings of Visceral Strikes
				{ 8, 51569 },	-- Dark Arctic Leggings
				{ 9, 60611 },	-- Dark Iceborne Leggings
				{ 10, 50945 },	-- Arctic Leggings
				{ 11, 50939 },	-- Iceborne Leggings
			},
			[MAIL_DIFF] = {
				{ 1, 70560 },	-- Draconic Bonesplinter Legguards
				{ 2, 70558 },	-- Lightning-Infused Leggings
				{ 3, 60754 },	-- Giantmaim Legguards
				{ 4, 60735 },	-- Swiftarrow Leggings
				{ 5, 60751 },	-- Stormhide Legguards
				{ 6, 60601 },	-- Dark Frostscale Leggings
				{ 7, 60627 },	-- Dark Nerubian Leggings
				{ 8, 50951 },	-- Frostscale Leggings
				{ 9, 50957 },	-- Nerubian Legguards
			},
		},
		{ -- Shoulder
			name = AL["Armor"].." - "..ALIL["Shoulder"],
			[LEATHER_DIFF] = {
				{ 1, 60758 },	-- Trollwoven Spaulders
				{ 2, 60702 },	-- Eviscerator's Shoulderpads
				{ 3, 60716 },	-- Overcast Spaulders
				{ 4, 60671 },	-- Purehorn Spaulders
				{ 5, 50946 },	-- Arctic Shoulderpads
				{ 6, 50940 },	-- Iceborne Shoulderpads
			},
			[MAIL_DIFF] = {
				{ 1, 60729 },	-- Swiftarrow Shoulderguards
				{ 2, 60746 },	-- Stormhide Shoulders
				{ 3, 60651 },	-- Virulent Spaulders
				{ 4, 50952 },	-- Frostscale Shoulders
				{ 5, 50958 },	-- Nerubian Shoulders
			},
		},
		{ -- Waist
			name = AL["Armor"].." - "..ALIL["Waist"],
			[LEATHER_DIFF] = {
				{ 1, 63200 },	-- Belt of Arctic Life
				{ 2, 63198 },	-- Death-warmed Belt
				{ 3, 60759 },	-- Trollwoven Girdle
				{ 4, 60997 },	-- Polar Cord
				{ 5, 60706 },	-- Eviscerator's Waistguard
				{ 6, 60723 },	-- Overcast Belt
				{ 7, 50949 },	-- Arctic Belt
				{ 8, 50943 },	-- Iceborne Belt
			},
			[MAIL_DIFF] = {
				{ 1, 63194 },	-- Belt of Dragons
				{ 2, 63196 },	-- Blue Belt of Chaos
				{ 3, 61000 },	-- Icy Scale Belt
				{ 4, 60734 },	-- Swiftarrow Belt
				{ 5, 60750 },	-- Stormhide Belt
				{ 6, 60658 },	-- Nightshock Girdle
				{ 7, 50955 },	-- Frostscale Belt
				{ 8, 50961 },	-- Nerubian Belt
			},
		},
		{ -- Wrist
			name = AL["Armor"].." - "..ALIL["Wrist"],
			[LEATHER_DIFF] = {
				{ 1, [ATLASLOOT_IT_ALLIANCE] = { 67087 }, [ATLASLOOT_IT_HORDE] = { 67139 } },	-- Bracers of Swift Death
				{ 2, [ATLASLOOT_IT_ALLIANCE] = { 67085 }, [ATLASLOOT_IT_HORDE] = { 67141 } },	-- Moonshadow Armguards
				{ 3, 60704 },	-- Eviscerator's Bindings
				{ 4, 60720 },	-- Overcast Bracers
				{ 5, 51571 },	-- Arctic Wristguards
				{ 6, 60607 },	-- Iceborne Wristguards
			},
			[MAIL_DIFF] = {
				{ 1, [ATLASLOOT_IT_ALLIANCE] = { 67081 }, [ATLASLOOT_IT_HORDE] = { 67137 } },	-- Black Chitin Bracers
				{ 2, [ATLASLOOT_IT_ALLIANCE] = { 67083 }, [ATLASLOOT_IT_HORDE] = { 67143 } },	-- Crusader's Dragonscale Bracers
				{ 3, 60755 },	-- Giantmaim Bracers
				{ 4, 60731 },	-- Swiftarrow Bracers
				{ 5, 60748 },	-- Stormhide Wristguards
				{ 6, 60652 },	-- Eaglebane Bracers
				{ 7, 60599 },	-- Frostscale Bracers
				{ 8, 60622 },	-- Nerubian Bracers
			},
		},
		{
			name = AL["Enhancements"],
			[NORMAL_DIFF] = {
				{ 1, 62448 },	-- Earthen Leg Armor
				{ 2, 50965 },	-- Frosthide Leg Armor
				{ 3, 50967 },	-- Icescale Leg Armor
				{ 5, 50964 },	-- Jormungar Leg Armor
				{ 6, 50966 },	-- Nerubian Leg Armor
				{ 8, 50963 },	-- Heavy Borean Armor Kit
			},
		},
		{
			name = AL["Drums"],
			[NORMAL_DIFF] = {
				{ 1, 69386 },	-- Drums of Forgotten Kings
				{ 2, 69388 },	-- Drums of the Wild
			},
		},
		{
			name = ALIL["Bag"],
			[NORMAL_DIFF] = {
				{ 1, 50971 },	-- Mammoth Mining Bag
				{ 2, 60643 },	-- Pack of Endless Pockets
				{ 3, 50970 },	-- Trapper's Traveling Pack
			},
		},
		{
			name = AL["Misc"],
			[NORMAL_DIFF] = {
				{ 1, 50936 },	-- Heavy Borean Leather
				{ 2, 64661 },	-- Borean Leather
			},
		},
		{ -- Sets
			name = AL["Sets"],
			ExtraList = true,
			TableType = SET_ITTYPE,
			[NORMAL_DIFF] = {
				{ 1, 754 }, -- Iceborne Embrace
				{ 2, 757 }, -- Borean Embrace
				{ 16, 756 }, -- Nerubian Hive
				{ 17, 755 }, -- Frostscale Binding
			},
		},
	}
}

data["JewelcraftingWrath"] = {
	name = ALIL["Jewelcrafting"],
	ContentType = PROF_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = private.JEWELCRAFTING_LINK,
	items = {
		{
			name = ALIL["Jewelcrafting"].." - "..ALIL["Gems"],
			[NORMAL_DIFF] = {
				-- red
				{ 1, 56049 },	-- Bold Dragon's Eye
				{ 2, 56052 },	-- Delicate Dragon's Eye
				{ 3, 56053 },	-- Runed  Dragon's Eye
				{ 4, 56054 },	-- Bright Dragon's Eye
				{ 5, 56055 },	-- Subtle Dragon's Eye
				{ 6, 56056 },	-- Flashing Dragon's Eye
				{ 7, 56076 },	-- Fractured Dragon's Eye
				{ 8, 56081 },	-- Precise Dragon's Eye
				-- blue
				{ 10, 56077 },	-- Lustrous Dragon's Eye
				{ 11, 56086 },	-- Solid Dragon's Eye
				{ 12, 56087 },	-- Sparkling Dragon's Eye
				{ 13, 56088 },	-- Stormy Dragon's Eye
				-- yellow
				{ 16, 56074 },	-- Brilliant Dragon's Eye
				{ 17, 56079 },	-- Mystic Dragon's Eye
				{ 18, 56083 },	-- Quick Dragon's Eye
				{ 19, 56084 },	-- Rigid Dragon's Eye
				{ 20, 56085 },	-- Smooth Dragon's Eye
				{ 21, 56089 },	-- Thick Dragon's Eye
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Neck"],
			[NORMAL_DIFF] = {
				{ 1, 56500 },	-- Titanium Earthguard Chain
				{ 2, 56499 },	-- Titanium Impact Choker
				{ 3, 56501 },	-- Titanium Spellshock Necklace
				{ 4, 73496 },	-- Alicite Pendant
				{ 5, 64725 },	-- Emerald Choker
				{ 6, 64726 },	-- Sky Sapphire Amulet
				{ 7, 56196 },	-- Blood Sun Necklace
				{ 8, 56195 },	-- Jade Dagger Pendant
			}
		},
		{
			name = AL["Armor"].." - "..AL["Ring"],
			[NORMAL_DIFF] = {
				{ 1, 56497 },	-- Titanium Earthguard Ring
				{ 2, 56496 },	-- Titanium Impact Band
				{ 3, 56498 },	-- Titanium Spellshock Ring
				{ 4, 58954 },	-- Titanium Frostguard Ring
				{ 5, 56197 },	-- Dream Signet
				{ 6, 58147 },	-- Ring of Earthen Might
				{ 7, 58150 },	-- Ring of Northern Tears
				{ 8, 58148 },	-- Ring of Scarlet Shadows
				{ 9, 64727 },	-- Runed Mana Band
				{ 10, 58507 },	-- Savage Titanium Band
				{ 11, 58492 },	-- Savage Titanium Ring
				{ 12, 64728 },	-- Scarlet Signet
				{ 13, 58149 },	-- Windfire Band
				{ 14, 58146 },	-- Shadowmight Ring
				{ 15, 58145 },	-- Stoneguard Band
				{ 16, 58143 },	-- Earthshadow Ring
				{ 17, 58144 },	-- Jade Ring of Slaying
				{ 18, 56193 },	-- Bloodstone Band
				{ 19, 56194 },	-- Sun Rock Ring
			}
		},
		{
			name = AL["Armor"].." - "..ALIL["Trinket"],
			[NORMAL_DIFF] = {
				{ 1, 56203 },	-- Figurine - Emerald Boar
				{ 2, 59759 },	-- Figurine - Monarch Crab
				{ 3, 56199 },	-- Figurine - Ruby Hare
				{ 4, 56202 },	-- Figurine - Sapphire Owl
				{ 5, 56201 },	-- Figurine - Twilight Serpent
			}
		},
		{
			name = format(GEM_FORMAT1, ALIL["Meta"]),
			[NORMAL_DIFF] = {
				{ 1, 55401 },	-- Austere Earthsiege Diamond
				{ 2, 55405 },	-- Beaming Earthsiege Diamond
				{ 3, 55397 },	-- Bracing Earthsiege Diamond
				{ 4, 55398 },	-- Eternal Earthsiege Diamond
				{ 5, 55396 },	-- Insightful Earthsiege Diamond
				{ 6, 55404 },	-- Invigorating Earthsiege Diamond
				{ 7, 55402 },	-- Persistant Earthsiege Diamond
				{ 8, 55399 },	-- Powerful Earthsiege Diamond
				{ 9, 55400 },	-- Relentless Earthsiege Diamond
				{ 10, 55403 },	-- Trenchant Earthsiege Diamond
				{ 16, 55389 },	-- Chaotic Skyflare Diamond
				{ 17, 55390 },	-- Destructive Skyflare Diamond
				{ 18, 55392 },	-- Ember Skyflare Diamond
				{ 19, 55393 },	-- Enigmatic Skyflare Diamond
				{ 20, 55387 },	-- Forlorn Skyflare Diamond
				{ 21, 55388 },	-- Impassive Skyflare Diamond
				{ 22, 55407 },	-- Revitalizing Skyflare Diamond
				{ 23, 55384 },	-- Shielded Skyflare Diamond
				{ 24, 55394 },	-- Swift Skyflare Diamond
				{ 25, 55395 },	-- Thundering Skyflare Diamond
				{ 26, 55386 },	-- Tireless Skyflare Diamond
			}
		},
		{
			name = format(GEM_FORMAT1, ALIL["Red"]),
			[NORMAL_DIFF] = {
				{ 1, 66447 },	-- Bold Cardinal Ruby
				{ 2, 66446 },	-- Runed Cardinal Ruby
				{ 3, 66448 },	-- Delicate Cardinal Ruby
				{ 4, 66453 },	-- Flashing Cardinal Ruby
				{ 5, 66450 },	-- Precise Cardinal Ruby
				{ 7, 53830 },	-- Bold Scarlet Ruby
				{ 8, 53946 },	-- Runed Scarlet Ruby
				{ 9, 53945 },	-- Delicate Scarlet Ruby
				{ 10, 53949 },	-- Flashing Scarlet Ruby
				{ 11, 53951 },	-- Precise Scarlet Ruby
				{ 16, 53831 },	-- Bold Bloodstone
				{ 17, 53834 },	-- Runed Bloodstone
				{ 18, 53832 },	-- Delicate Bloodstone
				{ 19, 53844 },	-- Flashing Bloodstone
				{ 20, 54017 },	-- Precise Bloodstone
			}
		},
		{
			name = format(GEM_FORMAT1, ALIL["Yellow"]),
			[NORMAL_DIFF] = {
				{ 1, 66503 },	-- Brilliant King's Amber
				{ 2, 66505 },	-- Mystic King's Amber
				{ 3, 66506 },	-- Quick King's Amber
				{ 4, 66501 },	-- Rigid King's Amber
				{ 5, 66502 },	-- Smooth King's Amber
				{ 6, 66504 },	-- Thick King's Amber
				{ 8, 53956 },	-- Brilliant Autumn's Glow
				{ 9, 53960 },	-- Mystic Autumn's Glow
				{ 10, 53961 },	-- Quick Autumn's Glow
				{ 11, 53958 },	-- Rigid Autumn's Glow
				{ 12, 53957 },	-- Smooth Autumn's Glow
				{ 13, 53959 },	-- Thick Autumn's Glow
				{ 16, 53852 },	-- Brilliant Sun Crystal
				{ 17, 53857 },	-- Mystic Sun Crystal
				{ 18, 53856 },	-- Quick Sun Crystal
				{ 19, 53854 },	-- Rigid Sun Crystal
				{ 20, 53853 },	-- Smooth Sun Crystal
				{ 21, 53855 },	-- Thick Sun Crystal
			}
		},
		{
			name = format(GEM_FORMAT1, ALIL["Blue"]),
			[NORMAL_DIFF] = {
				{ 1, 66498 },	-- Sparkling Majestic Zircon
				{ 2, 66497 },	-- Solid Majestic Zircon
				{ 3, 66498 },	-- Lustrous Majestic Zircon
				{ 4, 66499 },	-- Stormy Majestic Zircon
				{ 6, 53953 },	-- Sparkling Sky Sapphire
				{ 7, 53952 },	-- Solid Sky Sapphire
				{ 8, 53954 },	-- Lustrous Sky Sapphire
				{ 9, 53955 },	-- Stormy Sky Sapphire
				{ 16, 53940 },	-- Sparkling Chalcedony
				{ 17, 53934 },	-- Solid Chalcedony
				{ 18, 53941 },	-- Lustrous Chalcedony
				{ 19, 53943 },	-- Stormy Chalcedony
			}
		},
		{
			name = format(GEM_FORMAT1, ALIL["Orange"]),
			[NORMAL_DIFF] = {
				{ 1, 66579 },	-- Champion's Ametrine
				{ 2, 66568 },	-- Deadly Ametrine
				{ 3, 66584 },	-- Deft Ametrine
				{ 4, 66583 },	-- Fierce Ametrine
				{ 5, 66567 },	-- Inscribed Ametrine
				{ 6, 66585 },	-- Lucent Ametrine
				{ 7, 66569 },	-- Potent Ametrine
				{ 8, 66574 },	-- Reckless Ametrine
				{ 9, 66586 },	-- Resolute Ametrine
				{ 10, 66582 },	-- Resplendent Ametrine
				{ 11, 66581 },	-- Stalwart Ametrine
				{ 12, 66571 },	-- Willful Ametrine
				{ 16, 53977 },	-- Champion's Monarch Topaz
				{ 17, 53979 },	-- Deadly Monarch Topaz
				{ 18, 53991 },	-- Deft Monarch Topaz
				{ 19, 54019 },	-- Fierce Monarch Topaz
				{ 20, 53975 },	-- Inscribed Monarch Topaz
				{ 21, 53981 },	-- Lucent Monarch Topaz
				{ 22, 53984 },	-- Potent Monarch Topaz
				{ 23, 53987 },	-- Reckless Monarch Topaz
				{ 24, 54023 },	-- Resolute Monarch Topaz
				{ 25, 53978 },	-- Resplendent Monarch Topaz
				{ 26, 53993 },	-- Stalwart Monarch Topaz
				{ 27, 53986 },	-- Willful Monarch Topaz
				{ 101, 53874 },	-- Champion's Huge Citrine
				{ 102, 53877 },	-- Deadly Huge Citrine
				{ 103, 53880 },	-- Deft Huge Citrine
				{ 104, 53876 },	-- Fierce Huge Citrine
				{ 105, 53872 },	-- Inscribed Huge Citrine
				{ 106, 53879 },	-- Lucent Huge Citrine
				{ 107, 53882 },	-- Potent Huge Citrine
				{ 108, 53885 },	-- Reckless Huge Citrine
				{ 109, 53893 },	-- Resolute Huge Citrine
				{ 110, 53875 },	-- Resplendent Huge Citrine
				{ 111, 53891 },	-- Stalwart Huge Citrine
				{ 112, 53884 },	-- Willful Huge Citrine
			}
		},
		{
			name = format(GEM_FORMAT1, ALIL["Green"]),
			[NORMAL_DIFF] = {
				{ 1, 66442 },	-- Energized Eye of Zul
				{ 2, 66434 },	-- Forceful Eye of Zul
				{ 3, 66431 },	-- Jagged Eye of Zul
				{ 4, 66439 },	-- Lightning Eye of Zul
				{ 5, 66435 },	-- Misty Eye of Zul
				{ 6, 66429 },	-- Nimble Eye of Zul
				{ 7, 66441 },	-- Radiant Eye of Zul
				{ 8, 66338 },	-- Regal Eye of Zul
				{ 9, 66443 },	-- Shattered Eye of Zul
				{ 10, 66428 },	-- Steady Eye of Zul
				{ 11, 66445 },	-- Turbid Eye of Zul
				{ 16, 54011 },	-- Energized Forest Emerald
				{ 17, 54001 },	-- Forceful Forest Emerald
				{ 18, 53996 },	-- Jagged Forest Emerald
				{ 19, 54009 },	-- Lightning Forest Emerald
				{ 20, 54003 },	-- Misty Forest Emerald
				{ 21, 53997 },	-- Nimble Forest Emerald
				{ 22, 54012 },	-- Radiant Forest Emerald
				{ 23, 53998 },	-- Regal Forest Emerald
				{ 24, 54014 },	-- Shattered Forest Emerald
				{ 25, 54000 },	-- Steady Forest Emerald
				{ 26, 54005 },	-- Turbid Forest Emerald
				{ 101, 53925 },	-- Energized Dark Jade
				{ 102, 53920 },	-- Forceful Dark Jade
				{ 103, 53916 },	-- Jagged Dark Jade
				{ 104, 53923 },	-- Lightning Dark Jade
				{ 105, 53922 },	-- Misty Dark Jade
				{ 106, 53917 },	-- Nimble Dark Jade
				{ 107, 53932 },	-- Radiant Dark Jade
				{ 108, 53918 },	-- Regal Dark Jade
				{ 109, 53933 },	-- Shattered Dark Jade
				{ 110, 53919 },	-- Steady Dark Jade
				{ 111, 53924 },	-- Turbid Dark Jade
			}
		},
		{
			name = format(GEM_FORMAT1, ALIL["Purple"]),
			[NORMAL_DIFF] = {
				{ 1, 66553 },	-- Balanced Dreadstone
				{ 2, 66560 },	-- Defender's Dreadstone
				{ 3, 66555 },	-- Glowing Dreadstone
				{ 4, 66561 },	-- Guardian's Dreadstone
				{ 5, 66564 },	-- Infused Dreadstone
				{ 6, 66562 },	-- Mysterious Dreadstone
				{ 7, 66563 },	-- Puissant Dreadstone
				{ 8, 66556 },	-- Purified Dreadstone
				{ 9, 66559 },	-- Regal Dreadstone
				{ 10, 66558 },	-- Royal Dreadstone
				{ 11, 66557 },	-- Shifting Dreadstone
				{ 12, 66554 },	-- Sovereign Dreadstone
				{ 13, 66565 },	-- Tenuous Dreadstone
				{ 16, 53969 },	-- Balanced Twilight Opal
				{ 17, 53972 },	-- Defender's Twilight Opal
				{ 18, 53965 },	-- Glowing Twilight Opal
				{ 19, 53974 },	-- Guardian's Twilight Opal
				{ 20, 53970 },	-- Infused Twilight Opal
				{ 21, 53968 },	-- Mysterious Twilight Opal
				{ 22, 53973 },	-- Puissant Twilight Opal
				{ 23, 53966 },	-- Purified Twilight Opal
				{ 24, 53971 },	-- Regal Twilight Opal
				{ 25, 53967 },	-- Royal Twilight Opal
				{ 26, 53963 },	-- Shifting Twilight Opal
				{ 27, 53962 },	-- Sovereign Twilight Opal
				{ 28, 53964 },	-- Tenuous Twilight Opal
				{ 101, 53866 },	-- Balanced Shadow Crystal
				{ 102, 53869 },	-- Defender's Shadow Crystal
				{ 103, 53862 },	-- Glowing Shadow Crystal
				{ 104, 53871 },	-- Guardian's Shadow Crystal
				{ 105, 53867 },	-- Infused Shadow Crystal
				{ 106, 53865 },	-- Mysterious Shadow Crystal
				{ 107, 53870 },	-- Puissant Shadow Crystal
				{ 108, 53863 },	-- Purified Shadow Crystal
				{ 109, 53868 },	-- Regal Shadow Crystal
				{ 110, 53864 },	-- Royal Shadow Crystal
				{ 111, 53860 },	-- Shifting Shadow Crystal
				{ 112, 53859 },	-- Sovereign Shadow Crystal
				{ 113, 53861 },	-- Tenuous Shadow Crystal
			}
		},
		{
			name = AL["Misc"],
			[NORMAL_DIFF] = {
				{ 1, 62242 },	-- Icy Prism
				{ 16, 56208 },	-- Shadow Jade Focusing Lens
				{ 17, 56206 },	-- Shadow Crystal Focusing Lens
				{ 18, 56205 },	-- Dark Jade Focusing Lens
			}
		},
	}
}

data["MiningWrath"] = {
	name = ALIL["Mining"],
	ContentType = PROF_GATH_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = private.MINING_LINK,
	items = {
		{
			name = AL["Smelting"],
			[NORMAL_DIFF] = {
				{ 1, 49258 }, -- Smelt Saronite
				{ 3, 49252 }, -- Smelt Cobalt
				{ 16, 55211 }, -- Smelt Titanium
				{ 18, 55208 }, -- Smelt Titansteel
			}
		},
	}
}

data["HerbalismWrath"] = {
	name = ALIL["Herbalism"],
	ContentType = PROF_GATH_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = NORMAL_ITTYPE,
	CorrespondingFields = private.HERBALISM_LINK,
	items = {
		{
			name = AL["Grand Master"],
			[NORMAL_DIFF] = {
				{ 1,  36906 }, -- Icethorn
				{ 2,  36905 }, -- Lichbloom
				{ 3,  36903 }, -- Adder's Tongue
				{ 4,  36907 }, -- Talandra's Rose
				{ 5,  36904 }, -- Tiger Lily
				{ 6,  36901 }, -- Goldclover
				{ 16,  36908 }, -- Frost Lotus
				{ 18,  37921 }, -- Deadnettle
			}
		},
	}
}

data["CookingWrath"] = {
	name = ALIL["Cooking"],
	ContentType = PROF_SEC_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = private.COOKING_LINK,
	items = {
		{
			name = ALIL["Agility"],
			[NORMAL_DIFF] = {
				{ 1, 57441 },	-- Blackened Dragonfin
			},
		},
		{
			name = ALIL["Strength"],
			[NORMAL_DIFF] = {
				{ 1, 57442 },	-- Dragonfin Filet
			},
		},
		{
			name = ALIL["Hit"],
			[NORMAL_DIFF] = {
				{ 1, 57437 },	-- Snapper Extreme
				{ 2, 62350 },	-- Worg Tartare
			},
		},
		{
			name = ALIL["Haste"],
			[NORMAL_DIFF] = {
				{ 1, 45570 },	-- Imperial Manta Steak
				{ 2, 45558 },	-- Very Burnt Worg
				{ 3, 45569 },	-- Baked Manta Ray
				{ 4, 45552 },	-- Roasted Worg
			},
		},
		{
			name = ALIL["Critical Strike"],
			[NORMAL_DIFF] = {
				{ 1, 45557 },	-- Spiced Worm Burger
				{ 2, 45571 },	-- Spicy Blue Nettlefish
				{ 3, 45565 },	-- Poached Nettlefish
				{ 4, 45551 },	-- Worm Delight
			},
		},
		{
			name = ALIL["Spirit"],
			[NORMAL_DIFF] = {
				{ 1, 57439 },	-- Cuttlesteak
			},
		},
		{
			name = ALIL["Attack Power"],
			[NORMAL_DIFF] = {
				{ 1, 45555 },	-- Mega Mammoth Meal
				{ 2, 45567 },	-- Poached Northern Sculpin
				{ 3, 45563 },	-- Grilled Sculpin
				{ 4, 45549 },	-- Mammoth Meal
			},
		},
		{
			name = ALIL["Attack Power"].." + "..ALIL["Spell Power"],
			[NORMAL_DIFF] = {
				{ 1, 58065 },	-- Dalaran Clam Chowder
			},
		},
		{
			name = ALIL["Armor Penetration Rating"],
			[NORMAL_DIFF] = {
				{ 1, 57436 },	-- Hearty Rhino
			},
		},
		{
			name = ALIL["Expertise"],
			[NORMAL_DIFF] = {
				{ 1, 57434 },	-- Rhinolicious Wormsteak
			},
		},
		{
			name = ALIL["Mana Per 5 Sec."],
			[NORMAL_DIFF] = {
				{ 1, 45559 },	-- Mighty Rhino Dogs
				{ 2, 57433 },	-- Spicy Fried Herring
				{ 3, 45566 },	-- Pickled Fangtooth
				{ 4, 45553 },	-- Rhino Dogs
			},
		},
		{
			name = AL["Feast"],
			[NORMAL_DIFF] = {
				{ 1, 45554 },	-- Great Feast
				{ 16, 57423 },	-- Fish Feast
			},
		},
		{
			name = ALIL["Food"],
			[NORMAL_DIFF] = {
				{ 1, 57421 },	-- Northern Stew
				{ 3, 64358 },	-- Black Jelly
				{ 4, 45561 },	-- Grilled Bonescale
				{ 5, 45562 },	-- Sauteed Goby
				{ 6, 45560 },	-- Smoked Rockfin
				{ 8, 53056 },	-- Kungaloosh
			},
		},
		{
			name = AL["Pet"],
			[NORMAL_DIFF] = {
				{ 1, 57440 },	-- Spiced Mammoth Treats
			},
		},
		{
			name = AL["Special"],
			[NORMAL_DIFF] = {
				{ 1, 57438 },	-- Blackened Worg Steak
				{ 2, 57443 },	-- Tracker Snacks
				{ 16, 57435 },	-- Critter Bites
			},
		},
	}
}

data["FirstAidWrath"] = {
	name = ALIL["First Aid"],
	ContentType = PROF_SEC_CONTENT,
	LoadDifficulty = NORMAL_DIFF,
	TableType = PROF_ITTYPE,
	CorrespondingFields = private.FIRSTAID_LINK,
	items = {
		{
			name = ALIL["First Aid"],
			[NORMAL_DIFF] = {
				{ 1, 45546 },	-- Heavy Frostweave Bandage
				{ 2, 45545 },	-- Frostweave Bandage
			}
		},
	}
}