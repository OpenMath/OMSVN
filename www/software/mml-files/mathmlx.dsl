<!DOCTYPE style-sheet PUBLIC "-//James Clark//DTD DSSSL Style Sheet//EN" [

<!--
     David Carlisle
     davidc@nag.co.uk
 
     Copyright 1998 Nag Ltd, The OpenMath Consortium. Esprit Project 24.969.
  -->


<!ENTITY dblib.dsl SYSTEM "dblib.dsl">

<!ENTITY mathml.dsl SYSTEM "mathml.dsl">


<!--
<!ENTITY my-debug CDATA
 "(lambda (x)
 ((lambda (a b) b)
 (debug (debug-body x))
 x))" >

-->

<!ENTITY  my-debug CDATA "(lambda (x) x)" >

<!ENTITY my-debug2 CDATA
 "(lambda (x)
 ((lambda (a b) b)
 (debug (debug-body x))
 x))" >


<!--
<!ENTITY  my-debug CDATA "(lambda (x) x)" >
-->



]>

&dblib.dsl;

&mathml.dsl;


<!-- Debugging.
     Extended version of my-debug, from Mulberry and also dblib.
     This version shows more information about node lists, and more
     type information for some types.
     Also it is called via an SGML entity rather than a DSSSL function
     So that the jade-primitive debug function reports a useful line
     number, rather than just the line of the file in which the
     my-debug function is defined.
  -->


(define debug
  (external-procedure "UNREGISTERED::James Clark//Procedure::debug"))

(define max-node-list-debug-length 5)

(define (debug-body x)
  `(,(cond ((node-list? x)
	    (if (node-list-empty? x)
		'empty-node-list
		`( ,(if (named-node-list? x)
			'named-node-list
			'node-list)
		   ,(node-list-length x)
		   ,(node-list-reduce 
		      (node-list-head x max-node-list-debug-length) 
		      (lambda (result n) 
			(string-append result
				       (cond ((gi n) (string-append "<" (gi n) ">" ))
					     ((equal? 'data-char (node-property 'class-name n))  (data n))
					     (else "<?>"))))
		      "" ))))
	   ((sosofo? x) 'sosofo)
	   ((procedure? x) 'procedure)
	   ((style? x) 'style)
	   ((address? x) 'address)
	   ((color? x) 'color)
	   ((color-space? x) 'color-space)
	   ((display-space? x) 'display-space)
	   ((inline-space? x) 'inline-space)
	   ((glyph-id? x) 'glyph-id)
	   ((glyph-subst-table? x) 'glyph-subst-table)
	   ((boolean? x) 'boolean)
	   ((symbol? x) 'symbol)
	   ((list? x) 'list)
	   ((pair? x) 'pair)
	   ((char? x) 'char)
	   ((string? x) 'string)
	   ((quantity? x) 'quantity)
	   ((keyword? x) 'keyword)
	   (else 'other))
    ,x))




<!-- Some bits from the dsssl report, mainly from the
     Mulberry site
  -->

(define (node-list-filter proc nl)
  (node-list-reduce nl
                    (lambda (result snl)
                      (if (proc snl)
                          (node-list snl result)
                          result))
                    (empty-node-list)))


(define (map f #!rest xs)
   (let ((map1 (lambda (f xs)           ; bootstrap version for unary F
                 (let loop ((xs xs))
                   (if (null? xs)
                       '()
                       (cons (f (car xs))
                             (loop (cdr xs))))))))
     (cond ((null? xs)
            '())
           ((null? (cdr xs))
            (map1 f (car xs)))
           (else
            (let loop ((xs xs))
              (if (null? (car xs))
                  '()
                  (cons (apply f (map1 car xs))
                        (loop (map1 cdr xs)))))))))


(define (node-list-head nl i)
  (if (zero? i) 
      (empty-node-list)
      (node-list (node-list-first nl)
;;; page 136 of dsssl spec appears to be wrong...
		 (node-list-head (node-list-rest nl)
				 (- i 1)))))

(define (zero? x) (equal? x 0))

(define (attribute name nl) 
 (node-list-map (lambda (snl) (named-node name (attributes snl))) nl))

(define (attribute-value name nl)
      (node-list-property 'value (attribute name nl)))

(define (node-list-property prop nl) (node-list-map (lambda (snl)
 (node-property prop snl default: (empty-node-list))) nl))



<!-- Style for the elements of the mathmlx DTD
     Well there isn't much to do here.
  -->


(element mathx
  (make paragraph
    (make simple-page-sequence
      page-height: 9in
      page-width:  7in
      min-leading: 2pt
      top-margin: 1in
      bottom-margin: 1in
      left-margin: 1in
      right-margin: 1in
      (process-children-trim))))

(element p
  (make paragraph
   space-before: (display-space 12pt)
   space-after: (display-space 2pt)
   (process-children-trim)))




