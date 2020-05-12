# dotfiles
Updated, more minimalist version of my personal dotfiles.
Just the basics, just what I use everyday.
Customizations focus on Emacs, and LaTeX.

To install, use GNU Stow.

## To use:
- Clone the repo into your home directory, into a .dotfiles directory.
- Navigate into said directory.
- Run the command `stow emacs` and `stow` whatever else you need.
- Done. Everything is symlinked up.

### A note on *.emacs.d*
This configuration is minimal, attempting to only utilize ELPA packages available via package managers in many GNU/Linux distributions.

### The packages needed are:
- 

### A note on *.gitconfig*
To use this git configuration, you also need the file **.gitconfig.local** with the file contents
```
[user]
	name = First Last
	email = example@example.edu
```
and any other private git configurations in your home directory.