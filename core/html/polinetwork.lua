-- polinetwork.lua
-- Filtro pandoc per la build HTML.
--
-- Un paragrafo composto solo da {\small ...} (es. "Ultimo aggiornamento")
-- diventa <p class="small">, così il CSS può riprodurre lo stile del PDF.

function Para(el)
  local c = el.content
  if #c == 1 and c[1].t == "Span" and #c[1].attr.classes == 0 then
    return pandoc.Div(pandoc.Para(c[1].content), { class = "small" })
  end
end
