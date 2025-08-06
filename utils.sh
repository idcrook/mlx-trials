#!/bin/echo error sourcing

# some helpers for a problem I am seeing
function conda_enter () {
    # make sure our conda venv is at the begining of path
    if [ -d $CONDA_PREFIX/bin ] ; then
        path=( $CONDA_PREFIX/bin  $path )
    fi
}

function conda_exit () {
    # leave virtual env
    conda deactivate     2>/dev/null || :

    # https://www.reddit.com/r/zsh/comments/d7h7gb/how_to_remove_unwanted_path_entries/
    # echo $PATH
    # path=( ${path[@]:#*${CONDA_DEFAULT_ENV}/bin} )
}

