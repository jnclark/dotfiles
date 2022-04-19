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

### A note on `.emacs.d`
This configuration is minimal, attempting to only utilize ELPA packages available via package managers in many GNU/Linux distributions.

### The packages needed are:
- 

### A note on `.gitconfig`
To use this git configuration, you also need the file `.gitconfig.local` with the file contents
```
[user]
	name = First Last
	email = example@example.edu
```
and any other private git configurations in your home directory.

For example, one useful private configuration might be if you wish to have a separate git configuration for work or school active only within a specific `/home/username/directory` directory, distinct from your main credentials.
To do so, you can include the following in your `gitconfig.local`:

```
[includeIf "gitdir/i:/home/username/directory/"]
	path = /home/username/.gitconfig.example
```
with the contents of `/home/username/.gitconfig.example` something along the lines of
```
[user]
	name = First Last
	email = example@notexample.org

[core]
	sshCommand = ssh -i ~/.ssh/id_example
```