# Dotfile

This repo contains my collection of dot files.

## Structure

Each subdirectory maps the structure of the home directory, enabling the
_stowing_ of dot files on a per project basis.

## Usage

Check out the repository and use GNU Stow to symlink the files/directories to the home folder.

### Creating Symlinks

To symlink everything within the `vim` folder to your home directory:

```
$ stow vim
```

### Removing Symlinks

To remove previously created vim symlinks:

```
$ stow -D vim
```
