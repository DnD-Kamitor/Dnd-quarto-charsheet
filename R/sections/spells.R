render_spells <- function(ch, pb, mod, mod_str) {
  sc <- ch$spellcasting
  ability_labels <- c(int="Intelligence", wis="Wisdom", cha="Charisma")

  cat('\n<div class="spell-page">\n')
  cat('<h2 class="spell-page-title">Spellcasting</h2>\n')

  # ── Header row ──────────────────────────────────────────────────────────────
  cat(sprintf('
<div class="spell-header">
  <div class="stat-box"><span class="stat-value">%s</span><label>Spellcasting Class</label></div>
  <div class="stat-box"><span class="stat-value">%s</span><label>Spellcasting Ability</label></div>
  <div class="stat-box"><span class="stat-value">%d</span><label>Spell Save DC</label></div>
  <div class="stat-box"><span class="stat-value">%s</span><label>Spell Attack Bonus</label></div>
</div>\n',
    ch$class,
    ability_labels[[sc$ability]],
    sc$spell_save_dc,
    sc$spell_attack_bonus))

  # ── Spell slots grid ────────────────────────────────────────────────────────
  cat('<div class="spell-slots">\n')
  for (lvl in names(sc$slots)) {
    slot <- sc$slots[[lvl]]
    total <- slot$total
    used  <- slot$used
    boxes <- paste0(
      strrep('<span class="slot-box used">&#9632;</span>', used),
      strrep('<span class="slot-box">&#9633;</span>', total - used))
    cat(sprintf('  <div class="slot-row"><label>Level %s</label> %s</div>\n', lvl, boxes))
  }
  cat('</div>\n')

  # ── Spell lists ─────────────────────────────────────────────────────────────
  spell_sections <- list(
    cantrips  = "Cantrips",
    level_1   = "1st Level",
    level_2   = "2nd Level",
    level_3   = "3rd Level",
    level_4   = "4th Level",
    level_5   = "5th Level",
    level_6   = "6th Level",
    level_7   = "7th Level",
    level_8   = "8th Level",
    level_9   = "9th Level"
  )
  cat('<div class="spell-lists">\n')
  for (key in names(spell_sections)) {
    spells <- sc$spells[[key]]
    if (!is.null(spells) && length(spells) > 0) {
      cat(sprintf('<div class="spell-level-block">\n<h3>%s</h3>\n<ul>\n',
                  spell_sections[[key]]))
      for (spell in spells) {
        cat(sprintf('  <li>%s</li>\n', spell))
      }
      cat('</ul>\n</div>\n')
    }
  }
  cat('</div>\n') # spell-lists
  cat('</div>\n') # spell-page
}
