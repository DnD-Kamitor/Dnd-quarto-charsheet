# Main render dispatcher — assembles the 2-page sheet
source("R/sections/header.R")
source("R/sections/ability_scores.R")
source("R/sections/combat.R")
source("R/sections/equipment.R")
source("R/sections/features.R")
source("R/sections/spells.R")

render_sheet <- function(ch, pb, mod, mod_str) {
  cat('<div class="sheet">\n')

  # ── PAGE 1: header + 3-column mechanics ────────────────────────────────────
  cat('<div class="page page-1">\n')
  render_header(ch)
  cat('<div class="sheet-body">\n')
  cat('<div class="col col-left">\n')
  render_ability_scores(ch, pb, mod, mod_str)
  cat('</div>\n')
  cat('<div class="col col-mid">\n')
  render_combat(ch, pb, mod, mod_str)
  cat('</div>\n')
  cat('<div class="col col-right">\n')
  render_equipment(ch)
  cat('</div>\n')
  cat('</div>\n') # sheet-body
  cat('</div>\n') # page-1

  # ── PAGE 2: features + spells ───────────────────────────────────────────────
  cat('<div class="page page-2">\n')
  render_features(ch)
  if (!is.null(ch$spellcasting)) {
    render_spells(ch, pb, mod, mod_str)
  }
  cat('</div>\n') # page-2

  cat('</div>\n') # sheet
}
