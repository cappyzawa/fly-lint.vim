# concourse-lint.vim
Vim Plugin for fly

## Installation
To install using [Vim-Plug](https://github.com/junegunn/vim-plug):
```
" add this line to your .vimrc file
Plug 'cappyzawa/concourse-lint.vim'
```

## Supported commands
|Command|Description|
|:---:|:---|
|ValidatePipeline|`fly validate-pipeline -c <editing-file>`|
|FormatPipeline|`fly format-pipeline -c <editing-file>`|
|ForceFormatPipeline|`fly format-pipeline -w -c <editing-file>`|

## Key mappings
If `g:concouse_lint_no_default_mappings` is not set to `v:true`, this plugin also defines following default mapping.

|Key|Command|
|:---:|:---:|
|<Leader>vp|ValidatePipeline|
|<Leader>fp|FormatPipeline|
|<Leader>ffp|ForceFormatPipeline|

## Settings
If `g:concourse_lint_auto` is set to `v:true`, this plugin also defines following setting.

```
augroup concourse_lint
  autocmd!
  autocmd BufWritePost *.yml call concourse_lint#validate()
augroup END
```
