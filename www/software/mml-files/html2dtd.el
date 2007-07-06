;;; MathML Entity Converter 

;;;HTML <PRE> description to SGML/XML entity declarations

;;; run M-x html2dtd in an emacs buffer containing the original HTML file.

;;; David Carlisle davidc@nag.co.uk
;;; Copyright 1998 Nag Ltd, The OpenMath Consortium. Esprit Project 24.969.


(defun html2dtd ()
  (interactive)
  (goto-char (point-min))
  (delete-region (point) (progn (re-search-forward " end navigation links -->") (point)))
  (re-search-forward "<H1>")
  (replace-match "<!--\n    ")
  (re-search-forward "</H1>")
  (replace-match " ")
  (re-search-forward "<H2>")
  (replace-match "    ")
  (if (re-search-forward "<BR>\n" (+ (point) 80) t)
  (replace-match " "))
  (re-search-forward "</H2>")
  (replace-match "")
  (insert (concat "\n\n    Converted from HTML table at
          http://www.w3.org/TR/REC-MathML-19980407/chap6/"
          (buffer-name) 
      "\n\n    Copyright 1998 Nag Ltd, The OpenMath Consortium. Esprit Project 24.969.\n-->\n"))
  (delete-region (point) (progn (re-search-forward "= *$") (point)))
  (narrow-to-region (point) (point-max))
  (delete-region (progn  (re-search-forward "</PRE>") (match-beginning 0))
                         (point-max))
  (unhexify)
  (goto-char (point-min))
  (while (re-search-forward "^[a-zA-Z]" (point-max)  t)
    (beginning-of-line)
    (insert "<!ENTITY ")
    (end-of-line)
    (insert "-->"))
  (widen))

(defun unhexify ()
 (interactive)
 (goto-char (point-min))
 (while (re-search-forward " \\([0-9A-F][0-9A-F][0-9A-F][0-9A-F]\\) " (point-max) t)
  (let (( h 
    (buffer-substring (match-beginning 1) (match-end 1))))
   (delete-region (- (match-beginning 1) 1) (match-end 1))
   (goto-char (- (match-beginning 1)1))
    (insert "CDATA \"\&\#")
    (insert (int-to-string(hex h 0)))
    (insert (concat ";\" -- u+" h " "))
    (forward-line 1)
)))
    

(defun hex (h d)
  (let* ((n (string-to-char h))
         (dd  (+ (* 16 d) (- n (if (< n 58) 48 55)))))
  (if (= (length h) 1)
     dd
   (hex (substring h 1 nil) dd))))


