/datum/lazy_template/virtual_domain/gondola_asteroid
	name = "Астероид Гондолы"
	desc = "Астероид, на котором растет обильный лес гондол. Мирно."
	map_name = "gondola_asteroid"
	help_text = "Какой чудесный лес. Здесь, в центре карты, лежит ящик с лутом. \
	Хм... Он не двигается. А вот гондолы, похоже, без проблем перемещают его. \
	Наверняка есть способ сдвинуть его самому..."
	key = "gondola_asteroid"
	map_name = "gondola_asteroid"
	safehouse_path = /datum/map_template/safehouse/shuttle_space

/// Very pushy gondolas, great for moving loot crates.
/obj/structure/closet/crate/secure/bitrunning/encrypted/gondola
	move_resist = MOVE_FORCE_STRONG

/mob/living/simple_animal/pet/gondola/virtual_domain
	health = 50
	loot = list(/obj/effect/decal/cleanable/blood/gibs, /obj/item/stack/sheet/animalhide/gondola = 1, /obj/item/food/meat/slab/gondola/virtual_domain = 1)
	maxHealth = 50
	move_force = MOVE_FORCE_VERY_STRONG
	move_resist = MOVE_FORCE_STRONG

/obj/item/food/meat/slab/gondola/virtual_domain
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/gondola_mutation_toxin/virtual_domain = 5,
	)

/datum/reagent/gondola_mutation_toxin/virtual_domain
	name = "Advanced Tranquility"
	gondola_disease = /datum/disease/transformation/gondola/virtual_domain

/datum/disease/transformation/gondola/virtual_domain
	stage_prob = 9
	new_form = /mob/living/simple_animal/pet/gondola/virtual_domain
