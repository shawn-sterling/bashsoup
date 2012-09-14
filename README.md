# Introduction

This is a frakenscript cobbled together from [tirmm@reddit](http://www.reddit.com/r/commandline/comments/zt6x9/what_are_your_favorite_custom_prompts/)

which was copied / translated from zsh made by [Steve Losh](http://stevelosh.com/blog/2010/02/my-extravagant-zsh-prompt/)

which was a fork from [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)

# Changes

- added __git_ps1 code into this script
- added PS1_RED color variable
- added exit code status to prompt, which is red if it's a none zero exit code.
- fixed the bash prompt so root would be a # instead of a $
- added it so git status was parsed. + = untracked files.  ± = changes to be commited.
