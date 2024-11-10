(import (chez-tk))

(define (check-guess guess number)
  (let ([guess-num (string->number guess)])
    (cond [(< guess-num number) "Too low"]
	  [(> guess-num number) "Too high"]
	  [else "Correct!"])))

(define update-label
  (lambda ()
    (label 'configure
	   'text: (check-guess (guess 'get) number))))

(define number
  (pseudo-random-generator-next! (make-pseudo-random-generator) 101))

(ttk-map-widgets 'all)

(define tk (tk-start))
(define mainframe (tk 'create-widget 'frame 'padding: '(3 3 12 12)))
(define guess (mainframe 'create-widget 'entry 'width: 7))
(define button (mainframe 'create-widget 'button
			  'width: 7
			  'text: 'Guess
			  'command: update-label))
(define label (mainframe 'create-widget 'label 'width: 7))

(tk/wm 'title tk "Guess the Number")
(tk/grid mainframe 'column: 0 'row: 0 'sticky: 'nwes)
(tk/grid (mainframe 'create-widget 'label 'text: "Guess a number between 0 and 100: ") 
	 'row: 1 'column: 1 'padx: 5 'pady: 5)
(tk/grid guess 'row: 1 'column: 2  'padx: 5 'pady: 5)
(tk/grid button 'row: 1 'column: 3 'padx: 5 'pady: 5)
(tk/grid label 'row: 1 'column: 4 'padx: 5 'pady: 5)

(tk/focus guess)
(tk/bind tk '<Return> update-label)
(tk-event-loop tk)
