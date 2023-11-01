/*Alopecia
 * No change to stealth
 * Slight increase to resistance
 * Increases stage speed
 * Increases transmissibility
 * Near critcal level
 * Bonus: Makes the mob lose hair.
*/
/datum/symptom/shedding
	name = "Алопеция"
	desc = "Вирус вызывает быстрое выпадение волос на голове и теле."
	illness = "Thin Skinned"
	stealth = 0
	resistance = 1
	stage_speed = 2
	transmittable = 2
	level = 4
	severity = 1
	base_message_chance = 50
	symptom_delay_min = 45
	symptom_delay_max = 90

/datum/symptom/shedding/Activate(datum/disease/advance/disease)
	. = ..()
	if(!.)
		return

	var/mob/living/affected_living = disease.affected_mob
	if(prob(base_message_chance))
		to_chat(affected_living, span_warning("[pick("Скальп чешется.", "Кожа шелушится.")]"))
	if(ishuman(affected_living))
		var/mob/living/carbon/human/affected_human = affected_living
		switch(disease.stage)
			if(3, 4)
				if((affected_human.hairstyle == "Bald") && (affected_human.hairstyle != "Balding Hair"))
					to_chat(affected_human, span_warning("Волосы начинают выпадать..."))
					addtimer(CALLBACK(src, PROC_REF(baldify), affected_human, FALSE), 5 SECONDS)
			if(5)
				if((affected_human.facial_hairstyle != "Shaved") || (affected_human.hairstyle != "Bald"))
					if(affected_human.hairstyle == "Balding Hair")
						to_chat(affected_human, span_warning("Остатки волос начинают выпадать..."))
					else
						to_chat(affected_human, span_warning("Волосы начинают выпадать..."))
					addtimer(CALLBACK(src, PROC_REF(baldify), affected_human, TRUE), 3 SECONDS)

/datum/symptom/shedding/proc/baldify(mob/living/carbon/human/baldie, fully_bald)
	if(fully_bald)
		baldie.set_facial_hairstyle("Shaved", update = FALSE)
		baldie.set_hairstyle("Bald", update = FALSE)
	else
		baldie.set_hairstyle("Balding Hair", update = FALSE)
	baldie.update_body_parts()
