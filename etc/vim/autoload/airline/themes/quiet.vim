let g:airline#themes#quiet#palette = {}

let s:N1   = [ '#00005f' , '#5f87af' , 17  , 67  ]
let s:N2   = [ '#ffffff' , '#444444' , 255 , 238 ]
let s:N3   = [ '#9cffd3' , '#202020' , 85  , 234 ]
let g:airline#themes#quiet#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)

let g:airline#themes#quiet#palette.accents = {
      \ 'red': [ '#ff0000' , '' , 160 , '' ]
      \ }

let pal = g:airline#themes#quiet#palette
for item in ['insert', 'replace', 'visual', 'inactive', 'ctrlp']
  exe "let pal.".item." = pal.normal"
  for suffix in ['_modified', '_paste']
    exe "let pal.".item.suffix." = pal.normal"
  endfor
endfor
