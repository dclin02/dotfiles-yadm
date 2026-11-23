function nvcall --wraps nvim --description "nvc para calls: sem staticcheck, tailwind, eslint e nvim-lint"
    NVIM_CALL=1 nvc $argv
end
