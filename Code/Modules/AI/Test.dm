mob
    var /list/targets = list()   // List of all potential targets
    var /mob/current_target = null   // The current target the mob is pursuing

    // Proc to look for targets in the mob's vicinity
    proc /AI()
        for(var /obj/mob/M in oview(5))  // Check all mobs within a 5-tile radius
            if(M != src)   // Ignore itself
                targets += M   // Add potential targets to the list
        ..()

    // Proc to select a target from the list of potential targets
    proc /choose_target()
        if(targets.len)  // If there are potential targets
            current_target = targets[1]  // Select the first one
        else
            current_target = null  // If no targets are available, set to null
        ..()

    // Proc to pursue and attack the current target
    proc /Attack()
        if(current_target && current_target in oview(5))  // If the target is within range
            if(current_target.hp <= 0)   // If the target is already dead
                targets -= current_target   // Remove the target from the list
                current_target = null   // Reset the current target
                return
            else
                // Move towards the target
                move(current_target.x - x, current_target.y - y)
                // Attack the target
        else
            current_target = null   // If the target is out of range, reset the current target
        ..()


