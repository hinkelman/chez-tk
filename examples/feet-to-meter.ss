;; example comes from https://tkdocs.com/tutorial/firstexample.html#code
;; TODO
;; loop through children to add padding
;; (tk/winfo 'children mainframe)
;; returns a string, e.g., ".g1.g2 .g1.g3 .g1.g4 .g1.g6 .g1.g7 .g1.g8"

(import (chez-tk))

(define (calculate item)
  (let ((number (string->number item)))
    (if (number? number)
        (number->string
         (/ (round (* number 0.3048 1000)) 10000))
        "")))

;; used for adding padding to mainframe
(ttk-map-widgets 'all)

(let* ((tk (tk-start))
       (mainframe (tk 'create-widget 'frame 'padding: '(3 3 12 12)))
       (feet (mainframe 'create-widget 'entry 'width: 7))
       (label (mainframe 'create-widget 'label))
       (calc-meters (lambda () 
		    (label 'configure 
			   'text: (calculate (feet 'get)))))
       (button (mainframe 'create-widget 'button
		          'text: 'Calculate
		          'command: calc-meters)))
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
  (tk/focus feet)
  (tk/bind tk '<Return> calc-meters)
  (tk-event-loop tk))
