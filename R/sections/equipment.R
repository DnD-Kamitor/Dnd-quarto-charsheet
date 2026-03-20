render_equipment <- function(ch) {

  # ── Personality / Ideals / Bonds / Flaws ───────────────────────────────────
  traits <- paste(ch$personality_traits, collapse = "<br>")
  cat(sprintf('
<div class="section-box personality">
  <div class="personality-row">
    <div class="pfield"><label>Personality Traits</label><p>%s</p></div>
    <div class="pfield"><label>Ideals</label><p>%s</p></div>
    <div class="pfield"><label>Bonds</label><p>%s</p></div>
    <div class="pfield"><label>Flaws</label><p>%s</p></div>
  </div>
</div>\n',
    traits, ch$ideals, ch$bonds, ch$flaws))

  # ── Equipment & Currency ────────────────────────────────────────────────────
  cu <- ch$currency
  cat(sprintf('
<div class="section-box equipment">
  <div class="currency-row">
    <div class="coin cp"><span>%d</span><label>CP</label></div>
    <div class="coin sp"><span>%d</span><label>SP</label></div>
    <div class="coin ep"><span>%d</span><label>EP</label></div>
    <div class="coin gp"><span>%d</span><label>GP</label></div>
    <div class="coin pp"><span>%d</span><label>PP</label></div>
  </div>
  <ul class="equipment-list">\n',
    cu$cp, cu$sp, cu$ep, cu$gp, cu$pp))
  for (item in ch$equipment) {
    cat(sprintf('    <li>%s</li>\n', item))
  }
  cat('  </ul>\n<label class="section-label">Equipment</label>\n</div>\n')
}
