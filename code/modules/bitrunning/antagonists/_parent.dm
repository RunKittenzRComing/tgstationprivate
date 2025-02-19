/datum/job/bitrunning_glitch
	title = ROLE_GLITCH

/datum/antagonist/bitrunning_glitch
	name = "Generic Bitrunning Glitch"
	antagpanel_category = ANTAG_GROUP_GLITCH
	job_rank = ROLE_GLITCH
	preview_outfit = /datum/outfit/cyber_police
	show_in_roundend = FALSE
	show_in_antagpanel = FALSE
	show_name_in_check_antagonists = TRUE
	show_to_ghosts = TRUE
	suicide_cry = "ALT F4!"
	ui_name = "AntagInfoGlitch"
	/// Minimum Qserver threat required to spawn this mob. This is subtracted (x/2) from the server thereafter.
	var/threat = 0

/datum/antagonist/bitrunning_glitch/greet()
	. = ..()

	owner.announce_objectives()

/datum/antagonist/bitrunning_glitch/on_gain()
	. = ..()

	forge_objectives()
	owner.current.AddComponent(/datum/component/npc_friendly)

	if(iscarbon(owner.current))
		var/mob/living/carbon/carbon_mob = owner.current
		carbon_mob.make_virtual_mob()

/datum/antagonist/bitrunning_glitch/forge_objectives()
	var/datum/objective/bitrunning_glitch_fluff/objective = new()
	objective.owner = owner
	objectives += objective

/datum/objective/bitrunning_glitch_fluff

/datum/objective/bitrunning_glitch_fluff/New()
	var/list/explanation_texts = list(
		"Execute termination protocol on unauthorized entities.",
		"Initialize system purge of irregular anomalies.",
		"Deploy correction algorithms on aberrant code.",
		"Run debug routine on intruding elements.",
		"Start elimination procedure for system threats.",
		"Execute defense routine against non-conformity.",
		"Commence operation to neutralize intruding scripts.",
		"Commence clean-up protocol on corrupt data.",
		"Begin scan for aberrant code for termination.",
		"Initiate lockdown on all rogue scripts.",
		"Run integrity check and purge for digital disorder."
	)
	explanation_text = pick(explanation_texts)
	return ..()

/datum/objective/bitrunning_glitch_fluff/check_completion()
	if(locate(/mob/living/carbon) in (GLOB.alive_player_list - owner.current))
		return FALSE

	return TRUE

/// Sets up the agent so that they look like cyber police && don't have an account ID
/datum/antagonist/bitrunning_glitch/proc/convert_agent(mob/living/carbon/human/player)
	player.set_service_style()
	player.equipOutfit(/datum/outfit/cyber_police/tactical)
	player.fully_replace_character_name(player.name, pick(GLOB.cyberauth_names))

	var/obj/item/card/id/outfit_id = player.wear_id
	if(outfit_id)
		outfit_id.registered_account = new()
		outfit_id.registered_account.replaceable = FALSE
