render_ability_scores <- function(ch, pb, mod, mod_str) {

  # ── Proficiency bonus & Inspiration ────────────────────────────────────────
  insp <- if (isTRUE(ch$inspiration)) "&#9733;" else "&#9734;"
  cat(sprintf('
<div class="top-stats">
  <div class="stat-box inspiration">
    <span class="stat-value">%s</span>
    <label>Inspiration</label>
  </div>
  <div class="stat-box proficiency">
    <span class="stat-value">+%d</span>
    <label>Proficiency Bonus</label>
  </div>
</div>\n', insp, pb))

  # ── Ability Score boxes ─────────────────────────────────────────────────────
  ability_names <- c(str="STRENGTH", dex="DEXTERITY", con="CONSTITUTION",
                     int="INTELLIGENCE", wis="WISDOM", cha="CHARISMA")
  cat('<div class="ability-scores">\n')
  for (key in names(ability_names)) {
    score <- ch$abilities[[key]]
    cat(sprintf('
  <div class="ability-box">
    <label class="ability-label">%s</label>
    <span class="ability-mod">%s</span>
    <span class="ability-score">%d</span>
  </div>\n',
      ability_names[[key]], mod_str(score), score))
  }
  cat('</div>\n')

  # ── Saving Throws ───────────────────────────────────────────────────────────
  skill_ability <- list(
    str="str", dex="dex", con="con", int="int", wis="wis", cha="cha"
  )
  save_labels <- c(str="Strength", dex="Dexterity", con="Constitution",
                   int="Intelligence", wis="Wisdom", cha="Charisma")
  cat('<div class="section-box saving-throws">\n<ul>\n')
  for (key in names(save_labels)) {
    prof  <- isTRUE(ch$saving_throws[[key]])
    base  <- mod(ch$abilities[[key]])
    total <- if (prof) base + pb else base
    dot   <- if (prof) "&#9679;" else "&#9675;"
    cat(sprintf('  <li><span class="dot">%s</span> <span class="sv">%s</span> %s</li>\n',
        dot, mod_str(total), save_labels[[key]]))
  }
  cat('</ul>\n<label class="section-label">Saving Throws</label>\n</div>\n')

  # ── Skills ──────────────────────────────────────────────────────────────────
  # (name, governing ability)
  skills_def <- list(
    acrobatics       = "dex",
    animal_handling  = "wis",
    arcana           = "int",
    athletics        = "str",
    deception        = "cha",
    history          = "int",
    insight          = "wis",
    intimidation     = "cha",
    investigation    = "int",
    medicine         = "wis",
    nature           = "int",
    perception       = "wis",
    performance      = "cha",
    persuasion       = "cha",
    religion         = "int",
    sleight_of_hand  = "dex",
    stealth          = "dex",
    survival         = "wis"
  )
  skill_display <- c(
    acrobatics="Acrobatics", animal_handling="Animal Handling",
    arcana="Arcana", athletics="Athletics", deception="Deception",
    history="History", insight="Insight", intimidation="Intimidation",
    investigation="Investigation", medicine="Medicine", nature="Nature",
    perception="Perception", performance="Performance", persuasion="Persuasion",
    religion="Religion", sleight_of_hand="Sleight of Hand",
    stealth="Stealth", survival="Survival"
  )

  cat('<div class="section-box skills">\n<ul>\n')
  for (key in names(skills_def)) {
    ability <- skills_def[[key]]
    prof_val <- if (!is.null(ch$skills)) ch$skills[[key]] else FALSE
    is_exp   <- identical(prof_val, "exp")
    is_prof  <- isTRUE(prof_val) || is_exp
    multiplier <- if (is_exp) 2 else if (is_prof) 1 else 0
    base  <- mod(ch$abilities[[ability]])
    total <- base + multiplier * pb
    dot   <- if (is_exp) "&#9632;" else if (is_prof) "&#9679;" else "&#9675;"
    abbr  <- toupper(substr(ability, 1, 3))
    cat(sprintf('  <li><span class="dot">%s</span> <span class="sv">%s</span> %s <span class="skill-ability">(%s)</span></li>\n',
        dot, mod_str(total), skill_display[[key]], abbr))
  }
  cat('</ul>\n<label class="section-label">Skills</label>\n</div>\n')

  # ── Passive Perception ──────────────────────────────────────────────────────
  perc_prof  <- isTRUE(ch$skills[["perception"]])
  perc_total <- 10 + mod(ch$abilities[["wis"]]) + if (perc_prof) pb else 0
  cat(sprintf('
<div class="section-box passive-perception">
  <span class="stat-value">%d</span>
  <label>Passive Wisdom (Perception)</label>
</div>\n', perc_total))

  # ── Proficiencies & Languages ───────────────────────────────────────────────
  cat('<div class="section-box prof-languages">\n')
  cat(sprintf('<p><strong>Armor:</strong> %s</p>\n', ch$armor_proficiencies))
  cat(sprintf('<p><strong>Weapons:</strong> %s</p>\n', ch$weapon_proficiencies))
  cat(sprintf('<p><strong>Tools:</strong> %s</p>\n', ch$tool_proficiencies))
  cat(sprintf('<p><strong>Languages:</strong> %s</p>\n', ch$languages))
  cat('<label class="section-label">Other Proficiencies &amp; Languages</label>\n</div>\n')
}
