;; example comes from https://tkdocs.com/tutorial/firstexample.html#code

;; (wak irregex) is available through Akku (https://akkuscm.org/packages/wak-irregex/)
(import (chez-tk)
        (only (wak irregex) irregex-split))

(define (calculate item)
  (let ((number (string->number item)))
    (if (number? number)
        (number->string
         (/ (round (* number 0.3048 10000)) 10000))
        "")))

;; used for adding padding to mainframe
(ttk-map-widgets 'all)

(define tk (tk-start))
(define mainframe (tk 'create-widget 'frame 'padding: '(3 3 12 12)))
(define feet (mainframe 'create-widget 'entry 'width: 7))
(define label (mainframe 'create-widget 'label))
(define calc-meters (lambda () 
		      (label 'configure 
			     'text: (calculate (feet 'get)))))
(define button (mainframe 'create-widget 'button
		          'text: 'Calculate
		          'command: calc-meters))
(tk/wm 'title tk "Feet to Meters")
(tk/grid mainframe 'column: 0 'row: 0 'sticky: 'nwes)
(tk/grid feet 'column: 2 'row: 1 'sticky: 'we)
(tk/grid label 'column: 2 'row: 2 'sticky: 'we)
(tk/grid button 'column: 3 'row: 3 'sticky: 'w)
(tk/grid (mainframe 'create-widget 'label 'text: "feet") 
	 'column: 3 'row: 1 'sticky: 'w)
(tk/grid (mainframe 'create-widget 'label 'text: "is equivalent to") 
	 'column: 1 'row: 2 'sticky: 'e)
(tk/grid (mainframe 'create-widget 'label 'text: "meters") 
	 'column: 3 'row: 2 'sticky: 'w)
(define children (irregex-split " " (tk/winfo 'children mainframe)))
(for-each (lambda (child) (tk-eval (string-append "grid configure " child " -padx 5 -pady 5"))) children)
(tk/focus feet)
(tk/bind tk '<Return> calc-meters)
(tk-event-loop tk)
