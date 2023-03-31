(setq inhibit-startup-message t) ;; hide the startup message
(tool-bar-mode -1) ;; hide the toolbar
(toggle-scroll-bar -1) ;; hide the scrollbar

(menu-bar-mode -1) ;; hide the menubar, acces with C-mouse3
(load-theme 'tsdh-dark t) ;;starter theme
(global-hl-line-mode 1) ;; highlights the current line.

;; set up saves to a central location for auto saves to not litter the
;; file tree
(setq auto-save-file-name-transforms
      '((".*" "~/.emacs.d/saves/\\1" t)))
(setq backup-directory-alist '((".*" . "~/.emacs.d/saves/")))
(add-to-list 'backup-directory-alist
             (cons tramp-file-name-regexp nil))

(server-start) ;;for synctex and emacsclient

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; AucTeX configuration & PDF Stuff ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'tex)
(require 'reftex)

(TeX-global-PDF-mode t)
(add-hook 'LaTeX-mode-hook (lambda ()
  (push
    '("Latexmk" "latexmk -pdf %s" TeX-run-TeX nil t
      :help "Run latexmk on file")
    TeX-command-list)))
(add-hook 'LaTeX-mode-hook (lambda ()
  (push
    '("Latexmk shell escape" "latexmk -pdf --shell-escape %s" TeX-run-TeX nil t
      :help "Run latexmk with shell escape on file")
    TeX-command-list)))
(add-hook 'TeX-mode-hook '(lambda () (setq TeX-command-default "Latexmk")))

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)

(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)

; enable auto-fill mode, nice for text
(add-hook 'LaTeX-mode-hook 'auto-fill-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)

;; for synctex
(TeX-source-correlate-mode t)
(setq TeX-view-program-selection '((output-pdf "Zathura")))

;; make reftex work with Auctex
(setq reftex-plug-into-AUCTeX t)

;; reftex insert non breaking space before cite
(setq reftex-format-cite-function
      '(lambda (key fmt)
	 (let ((cite (replace-regexp-in-string "%l" key fmt)))
	   (if (or (= ?~ (string-to-char fmt))
		   (member (preceding-char) '(?\ ?\t ?\n ?~)))
	       cite
	     (concat "~" cite)))))

(setq reftex-label-alist
      '(("axiom" ?a "ax:"  "~\\ref{%s}" t ("axiom"   "ax.") -2)
	("definition" ?d "def:"  "~\\ref{%s}" t ("definition"   "df.") -3)
	("conjecture" ?c "conj:"  "~\\ref{%s}" t ("conjecture"   "cj.") -3)
	("algorithm" ?g "alg:"  "~\\ref{%s}" t ("algorithm"   "al.") -4)
	("theorem" ?h "thm:" "~\\ref{%s}" t   ("theorem" "th.") -3)
	("proposition" ?p "prop:" "~\\ref{%s}" t   ("proposition" "pp.") -3)
	("lemma" ?m "lem:" "~\\ref{%s}" t   ("lemma" "lm.") -3)
	("claim" ?x "claim:" "~\\ref{%s}" t   ("claim" "cl.") -3)
	("case" ?y "case:" "~\\ref{%s}" t   ("case" "cs.") -4)))

(add-hook 'LaTeX-mode-hook
	  (lambda ()
	    (LaTeX-add-environments
	     '("axiom" LaTeX-env-label)
	     '("definition" LaTeX-env-label)
	     '("conjecture" LaTeX-env-label)
	     '("algorithm" LaTeX-env-label)
	     '("theorem" LaTeX-env-label)
	     '("proposition" LaTeX-env-label)
	     '("lemma" LaTeX-env-label)
	     '("claim" LaTeX-env-label)
	     '("case" LaTeX-env-label))))

;; for cleveref and nameref
(setq reftex-ref-style-alist
      (quote
       (("Default" t
	 (("\\ref" 13)
	  ("\\pageref" 112)))
	("Varioref" "varioref"
	 (("\\vref" 118)
	  ("\\vpageref" 103)
	  ("\\Vref" 86)
	  ("\\Ref" 82)))
	("Fancyref" "fancyref"
	 (("\\fref" 102)
	  ("\\Fref" 70)))
	("Hyperref" "hyperref"
	 (("\\autoref" 97)
	  ("\\autopageref" 117)))
	("Cleveref" "cleveref"
	 (("\\cref" 99)
	  ("\\Cref" 67)
	  ("\\cpageref" 100)
	  ("\\Cpageref" 68)))
	("Nameref" "nameref"
	 (("\\nameref" 110))))))
(setq reftex-ref-style-default-list (quote ("Cleveref" "Nameref" "Default")))

;; end LaTeX

;;;;;;;;;;;;;;;;;;;;;;;;
;;   C/C++ settings   ;;
;;;;;;;;;;;;;;;;;;;;;;;;

(setq c-default-style
      '((awk-mode . "awk")
        (other . "linux")))

(add-hook 'c++-mode-hook
          '(lambda () 
             (setq-default indent-tabs-mode nil)
             (setq c-basic-indent 4)
             (setq tab-width 4)))


;; end C/C++

;;;;;;;;;;;;;;;;;;;;;;;
;;  Python settings  ;;
;;;;;;;;;;;;;;;;;;;;;;;

;; elpy (using default env/nix shell env)
(setq elpy-rpc-python-command "python")
(setq elpy-rpc-virtualenv-path 'global)
(setq python-shell-interpreter "python")

;; end Python

;;;;;;;;;;;;;;;;;;;;;;;;
;; yasnippet settings ;;
;;;;;;;;;;;;;;;;;;;;;;;;

(require 'yasnippet)
(yas-global-mode 1)
(setq yas-triggers-in-field t) ;; can expand snippet inside snippet
(advice-add 'yas--auto-fill-wrapper :override #'ignore);; add autofill workaround

;; end yasnippet settings

;;;;;;;;;;;;;;;;;;;;;;;;
;; delimiter settings ;;
;;;;;;;;;;;;;;;;;;;;;;;;

(setq show-paren-delay 0)
(show-paren-mode 1)

;;autopair like behavior with electric-pair-mode
(electric-pair-mode t)
(setq-default electric-pair-inhibit-predicate 'electric-pair-conservative-inhibit)

;; end delimiter settings

;;;;;;;;;;;;;;;;;;;;;;;
;; org mode settings ;;
;;;;;;;;;;;;;;;;;;;;;;;

(org-babel-do-load-languages
 'org-babel-load-languages
 '((calc . t)
   (sed . t)
   (shell . t)
   (eshell . t)
   (C . t)
   (python . t)
   (haskell . t)
   (sql . t)
   (sqlite . t)))


;;;;;;;;;;;;;;;;;;;;
;; Custom Keymaps ;;
;;;;;;;;;;;;;;;;;;;;

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)
