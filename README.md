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
$ stow -t ~ vim
```

### Removing Symlinks

To remove previously created vim symlinks:

```
$ stow -t ~ -D vim
```

### Using direnv for Separating Personal and Work Config Options

[direnv](https://direnv.net/) is sourced from within the `.bashrc` config file. The following is an example `.envrc` file for configuring the git username and email:

```
export GIT_AUTHOR_NAME="***"
export GIT_AUTHOR_EMAIL="***"
export GIT_COMMITTER_NAME=$GIT_AUTHOR_NAME
export GIT_COMMITTER_EMAIL=$GIT_AUTHOR_EMAIL
```

