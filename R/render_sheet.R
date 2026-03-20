# Main render dispatcher — sources section renderers and assembles the sheet
source("R/sections/header.R")
source("R/sections/ability_scores.R")
source("R/sections/combat.R")
source("R/sections/equipment.R")
source("R/sections/spells.R")

render_sheet <- function(ch, pb, mod, mod_str) {
  cat('<div class="sheet">\n')
  render_header(ch)
  cat('<div class="sheet-body">\n')
  cat('<div class="col col-left">\n')
  render_ability_scores(ch, pb, mod, mod_str)
  cat('</div>\n') # col-left
  cat('<div class="col col-mid">\n')
  render_combat(ch, pb, mod, mod_str)
  cat('</div>\n') # col-mid
  cat('<div class="col col-right">\n')
  render_equipment(ch)
  cat('</div>\n') # col-right
  cat('</div>\n') # sheet-body
  if (!is.null(ch$spellcasting)) {
    render_spells(ch, pb, mod, mod_str)
  }
  cat('</div>\n') # sheet
}
