render_header <- function(ch) {
  cat(sprintf('
<div class="sheet-header">
  <div class="char-name-box">
    <span class="char-name">%s</span>
    <label>Character Name</label>
  </div>
  <div class="header-fields">
    <div class="hfield"><span>%s %s</span><label>Class &amp; Level</label></div>
    <div class="hfield"><span>%s</span><label>Background</label></div>
    <div class="hfield"><span>%s</span><label>Race</label></div>
    <div class="hfield"><span>%s</span><label>Alignment</label></div>
    <div class="hfield"><span>%s</span><label>Experience Points</label></div>
  </div>
</div>\n',
    ch$name,
    ch$class, ch$level,
    ch$background,
    ch$race,
    ch$alignment,
    ch$experience_points
  ))
}
