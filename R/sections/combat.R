render_combat <- function(ch, pb, mod, mod_str) {

  # ── Top row: AC / Initiative / Speed ───────────────────────────────────────
  init <- mod(ch$abilities[["dex"]])
  cat(sprintf('
<div class="combat-top">
  <div class="stat-box"><span class="stat-value">%d</span><label>Armor Class</label></div>
  <div class="stat-box"><span class="stat-value">%s</span><label>Initiative</label></div>
  <div class="stat-box"><span class="stat-value">%d</span><label>Speed</label></div>
</div>\n',
    ch$armor_class,
    mod_str(ch$abilities[["dex"]]),
    ch$speed))

  # ── HP block ────────────────────────────────────────────────────────────────
  cat(sprintf('
<div class="section-box hp-block">
  <div class="hp-max">
    <label>Hit Point Maximum</label>
    <span>%d</span>
  </div>
  <div class="hp-current">
    <div class="hp-row">
      <div><label>Current Hit Points</label><span class="hp-value">%d</span></div>
    </div>
  </div>
  <div class="hp-temp">
    <label>Temporary Hit Points</label>
    <span class="hp-value">%s</span>
  </div>
</div>\n',
    ch$hp_max,
    ch$hp_current,
    if (ch$hp_temp > 0) ch$hp_temp else "—"))

  # ── Hit Dice / Death Saves ──────────────────────────────────────────────────
  suc <- ch$death_saves$successes
  fai <- ch$death_saves$failures
  suc_boxes <- paste0(
    strrep('<span class="ds-box filled">&#9679;</span>', suc),
    strrep('<span class="ds-box">&#9675;</span>', 3 - suc))
  fai_boxes <- paste0(
    strrep('<span class="ds-box failed">&#9679;</span>', fai),
    strrep('<span class="ds-box">&#9675;</span>', 3 - fai))

  cat(sprintf('
<div class="hd-ds-row">
  <div class="section-box hit-dice">
    <label>Hit Dice</label>
    <span class="stat-value">%s</span>
  </div>
  <div class="section-box death-saves">
    <label>Death Saves</label>
    <div class="ds-row"><span>Successes</span> %s</div>
    <div class="ds-row"><span>Failures</span> %s</div>
  </div>
</div>\n',
    ch$hit_dice, suc_boxes, fai_boxes))

  # ── Attacks & Spellcasting ──────────────────────────────────────────────────
  cat('<div class="section-box attacks">\n')
  cat('<table class="attack-table">\n')
  cat('<thead><tr><th>Name</th><th>Atk Bonus</th><th>Damage/Type</th></tr></thead>\n')
  cat('<tbody>\n')
  for (atk in ch$attacks) {
    cat(sprintf('<tr><td>%s</td><td>%s</td><td>%s %s</td></tr>\n',
      atk$name, atk$bonus, atk$damage, atk$type))
  }
  cat('</tbody>\n</table>\n')
  cat('<label class="section-label">Attacks &amp; Spellcasting</label>\n</div>\n')
}
