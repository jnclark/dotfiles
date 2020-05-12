$pdf_mode = 1;
$pdf_previewer = 'start zathura';
#$preview_continuous_mode = 1;
#$out_dir = 'build';

push @extra_pdflatex_options, '-synctex=1' ;

## Un-comment for auto-latexmk on systems using sage from
## a source other than the package manager.
## This might not be neccesary, depending on your TeX settup and settings.
## If needed, you must locate the python script for your system.
# Set aliases for latexmkrc so it can handle running SageTeX if neccesary
# $latex = "$latex ; python /usr/lib/sagemath/local/share/texmf/tex/latex/sagetex/run-sagetex-if-necessary.py %B";
# $pdflatex = "$pdflatex ; python /usr/lib/sagemath/local/share/texmf/tex/latex/sagetex/run-sagetex-if-necessary.py %B";

# Set SageTeX deps 
add_cus_dep( 'sage', 'sout', 0, 'makesout' );
$hash_calc_ignore_pattern{'sage'} = '^( _st_.goboom|print .SageT)';
sub makesout {
   system( "sage \"$_[0].sage\"" );
}

# Set pythontex deps
add_cus_dep('pytxcode', 'tex', 0, 'pythontex');
sub pythontex {
    # This subroutine makes the main .tex file depend on the
    # .pytxcode file to make latexmk work its magic
    # i.e. run whenever the .pytxcode file changes,
    # prior to running pdflatex again.
    return system("pythontex \"$_[0].pytxcode\"") ;
}