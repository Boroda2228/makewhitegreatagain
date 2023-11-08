//kills unconscious targets and turns them into blob zombies, produces fragile spores when killed.  Spore produced by factories are sentient.
/datum/blobstrain/reagent/distributed_neurons
	name = "Распределенные нейроны"
	description = "нанесет очень низкий урон токсином и превратит потерявшие сознание цели в зомби-массы."
	effectdesc = "при гибели также образует хрупкие споры. Споры, производимые фабриками, разумны."
	shortdesc = "нанесет очень низкий урон токсинами и убьет любые находящиеся в бессознательном состоянии цели при атаке. Споры, производимые фабриками, разумны."
	analyzerdescdamage = "Наносит очень низкий урон токсинами и убивает людей без сознания."
	analyzerdesceffect = "При смерти образует споры. Споры, производимые фабриками, разумны."
	color = "#E88D5D"
	complementary_color = "#823ABB"
	message_living = " и хочется спать"
	reagent = /datum/reagent/blob/distributed_neurons

/datum/blobstrain/reagent/distributed_neurons/damage_reaction(obj/structure/blob/blob_tile, damage, damage_type, damage_flag)
	if((damage_flag == MELEE || damage_flag == BULLET || damage_flag == LASER) && damage <= 20 && blob_tile.get_integrity() - damage <= 0 && prob(15)) //if the cause isn't fire or a bomb, the damage is less than 21, we're going to die from that damage, 15% chance of a shitty spore.
		blob_tile.visible_message(span_boldwarning("<b>Спора вылетает из массы!</b>"))
		blob_tile.overmind.create_spore(blob_tile.loc, /mob/living/basic/blob_minion/spore/minion/weak)
	return ..()

/datum/reagent/blob/distributed_neurons
	name = "Распределенные нейроны"
	enname = "Distributed Neurons"
	color = "#E88D5D"

/datum/reagent/blob/distributed_neurons/expose_mob(mob/living/exposed_mob, methods=TOUCH, reac_volume, show_message, touch_protection, mob/camera/blob/overmind)
	. = ..()
	reac_volume = return_mob_expose_reac_volume(exposed_mob, methods, reac_volume, show_message, touch_protection, overmind)
	exposed_mob.apply_damage(0.6*reac_volume, TOX)
	if(overmind && ishuman(exposed_mob))
		if(exposed_mob.stat == UNCONSCIOUS || exposed_mob.stat == HARD_CRIT)
			exposed_mob.investigate_log("has been killed by distributed neurons (blob).", INVESTIGATE_DEATHS)
			exposed_mob.death() //sleeping in a fight? bad plan.
		if(exposed_mob.stat == DEAD && overmind.can_buy(5))
			var/mob/living/basic/blob_minion/spore/minion/spore = overmind.create_spore(get_turf(exposed_mob))
			spore.zombify(exposed_mob)
			overmind.add_points(-5)
			to_chat(overmind, span_notice("Тратим 5 ресурсов на зомбификацию [exposed_mob]."))
