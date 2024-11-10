(import (chez-tk))

(define (check-guess guess number)
  (let ([guess-num (string->number guess)])
    (cond [(< guess-num number) "Too low"]
	  [(> guess-num number) "Too high"]
	  [else "Correct!"])))

(define (update-count count)
  (number->string
   (add1 (string->number count))))

(define update
  (lambda ()
    (check 'configure 'text: (check-guess (guess 'get) number))
    (count 'configure 'text: (update-count (count 'cget 'text:)))))

(define number
  (pseudo-random-generator-next! (make-pseudo-random-generator) 101))

(ttk-map-widgets 'all)

(define tk (tk-start))
(define mainframe (tk 'create-widget 'frame 'padding: '(3 3 12 12)))
(define guess (mainframe 'create-widget 'entry 'width: 7))
(define count (mainframe 'create-widget 'label 'text: "0" 'width: 7))
(define check (mainframe 'create-widget 'label 'width: 7))
(define button (mainframe 'create-widget 'button
			  'width: 7
			  'text: 'Guess
			  'command: update))

(tk/wm 'title tk "Guess the Number")
(tk/grid mainframe 'column: 0 'row: 0 'sticky: 'nwes)
(tk/grid (mainframe 'create-widget 'label 'text: "Guess a number between 0 and 100: ") 
	 'row: 1 'column: 1 'sticky: 'e 'padx: 5 'pady: 5)
(tk/grid guess 'row: 1 'column: 2  'padx: 5 'pady: 5)
(tk/grid button 'row: 1 'column: 3 'padx: 5 'pady: 5)
(tk/grid (mainframe 'create-widget 'label 'text: "Guesses: ") 
	 'row: 2 'column: 1 'sticky: 'e 'padx: 5 'pady: 5)
(tk/grid count 'row: 2 'column: 2 'padx: 5 'pady: 5)
(tk/grid check 'row: 2 'column: 3 'padx: 5 'pady: 5)

(tk/focus guess)
(tk/bind tk '<Return> update)
(tk-event-loop tk)
