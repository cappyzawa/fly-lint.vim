# fly-lint.vim
Vim Plugin to lint concourse pipeline

## Installation
To install using [Vim-Plug](https://github.com/junegunn/vim-plug):
```
" add this line to your .vimrc file
Plug 'cappyzawa/fly-lint.vim'
```

## Supported commands
|Command|Description|
|:---|:---|
|ValidatePipeline|`fly validate-pipeline -c <editing-file>`|
|FormatPipeline|`fly format-pipeline -c <editing-file>`|
|ForceFormatPipeline|`fly format-pipeline -w -c <editing-file>`|
|EnableAutoValidatePipeline|current buffer is validated automatically(`autocmd BufWritePost`)|
|DisableAutoValidatePipeline|disable automatical validation(`EnableAutoValidatePipeline`)|

## Key mappings
If `g:fly_lint_no_default_mappings` is not set to `v:true`, this plugin also defines following default mapping.

|Key|Command|
|:---:|:---|
|<Leader\>vp|ValidatePipeline|
|<Leader\>fp|FormatPipeline|
|<Leader\>ffp|ForceFormatPipeline|
|<Leader\>ea|EnableAutoValidatePipeline|
|<Leader\>da|DisableAutoValidatePipeline|
