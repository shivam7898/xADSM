function RawInline (el)
  if el.format == 'tex' then
    local blocks = pandoc.read(el.text, 'latex').blocks
    return blocks[1] and blocks[1].content or el
  end
end
