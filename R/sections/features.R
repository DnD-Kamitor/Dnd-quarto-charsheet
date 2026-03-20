render_features <- function(ch) {
  cat('<div class="page-2-header">\n')
  cat(sprintf('<span class="p2-char-name">%s</span>', ch$name))
  cat(sprintf(' &mdash; <span class="p2-char-class">%s %s, Level %d</span>\n',
              ch$race, ch$class, ch$level))
  cat('</div>\n')

  cat('<div class="features-grid">\n')

  # ── Features & Traits ───────────────────────────────────────────────────────
  cat('<div class="section-box features">\n<ul class="feature-list">\n')
  for (feat in ch$features) {
    cat(sprintf('  <li><strong>%s.</strong> %s</li>\n', feat$name, feat$description))
  }
  cat('</ul>\n<label class="section-label">Features &amp; Traits</label>\n</div>\n')

  # ── Additional notes box (blank for handwriting) ────────────────────────────
  cat('<div class="section-box notes-box">\n')
  cat('<label class="section-label">Additional Notes</label>\n')
  cat('</div>\n')

  cat('</div>\n') # features-grid
}
