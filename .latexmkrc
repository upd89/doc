$pdflatex = 'pdflatex -interaction=nonstopmode -shell-escape';

add_cus_dep('glo', 'gls', 0, 'makeglossaries');
sub makeglossaries {
	system("makeglossaries \"$_[0]\"");
}

