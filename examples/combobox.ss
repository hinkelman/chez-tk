;; example is basically same as listbox.ss but uses combobox instead of listbox

(import (chez-tk))

;; convert list of strings into a string with a space between list elements
(define (string-append-space lst)
  (let loop ([lst lst]
	     [out '()])
    (let ([sp (if (null? out) "" " ")])
      (if (null? lst)
	  (apply string-append (reverse out))
	  (loop (cdr lst) (cons (car lst) (cons sp out)))))))

(define (get-idx sel lst)
  (let loop ([lst lst]
	     [idx 0])
    (if (string=? sel (car lst))
	idx
	(loop (cdr lst) (add1 idx)))))

(define country-codes '(ar au be br ca cn dk fi fr gr in it jp mx nl no es se ch))
(define country-names '("Argentina" "Australia" "Belgium" "Brazil" "Canada" "China" "Denmark"
			"Finland" "France" "Greece" "India" "Italy" "Japan" "Mexico"
			"Netherlands" "Norway" "Spain" "Sweden" "Switzerland"))
(define cnames-str (string-append-space country-names))

(define pops '(41000000 21179211 10584534 185971537 33148682 1323128240 5457415 5302000
                        64102140 11147000 1131043000 59206382 127718000 106535000 16402414
                        4738085 45116894 9174082 7508700))
(define populations (map (lambda (cc pop) (cons cc pop)) country-codes pops))
(define gifts '(("card" "Greeting card") ("flowers" "Flowers") ("nastygram" "Nastygram")))

(define (show-pop country-selected country-codes country-names pops)
  (let* ([idx (get-idx country-selected country-names)]
	 [code (list-ref country-codes idx)]
	 [popn (list-ref pops idx)])
    (format "The population of ~a (~s) is ~d" country-selected code popn)))

(define (send-gift country-selected gift country-names gifts)
  (let* ([idx (get-idx country-selected country-names)]
	 [g (cadr (assoc gift gifts))])
    (string-append "Sent " g " to leader of " country-selected)))

(define show-pop-cmd
  (lambda ()
    (tk-set-var! 'sentmsg "")
    (tk-set-var!
     'statusmsg
     (show-pop (cbox 'get) country-codes country-names pops))))

(define send-gift-cmd
  (lambda ()
    (tk-set-var!
     'sentmsg
     (send-gift (cbox 'get) (tk-get-var 'gift) country-names gifts))))

(ttk-map-widgets 'all)
(define tk (tk-start))
(define c (tk 'create-widget 'frame 'padding: '(5 5 5 5)))
(define cbox (c 'create-widget 'combobox 'values: cnames-str 'state: 'readonly))
(define lbl (c 'create-widget 'label 'text: "Send to country's leader:"))
(define g1 (c 'create-widget 'radiobutton 'text: "Greeting card" 'variable: (tk-var 'gift) 'value: "card"))
(define g2 (c 'create-widget 'radiobutton 'text: "Flowers" 'variable: (tk-var 'gift) 'value: "flowers"))
(define g3 (c 'create-widget 'radiobutton 'text: "Nastygram" 'variable: (tk-var 'gift) 'value: "nastygram"))
(define send (c 'create-widget 'button 'text: "Send Gift" 'command: send-gift-cmd))
(define sentlbl (c 'create-widget 'label 'textvariable: (tk-var 'sentmsg) 'anchor: 'center))
(define status (c 'create-widget 'label 'textvariable: (tk-var 'statusmsg) 'anchor: 'w))

;; Grid all the widgets
(tk/grid c)
(tk/grid cbox 'column: 0 'row: 0 'columnspan: 2 'sticky: 'nsew)
(tk/grid status 'column: 0 'row: 1 'columnspan: 2 'sticky: 'we 'pady: 5)
(tk/grid lbl 'column: 0 'row: 2 'pady: 5 'sticky: 'w)
(tk/grid g1 'column: 0 'row: 3 'sticky: 'w)
(tk/grid g2 'column: 0 'row: 4 'sticky: 'w)
(tk/grid g3 'column: 0 'row: 5 'sticky: 'w)
(tk/grid send 'column: 1 'row: 6 'sticky: 'e)
(tk/grid sentlbl 'column: 0 'row: 7 'columnspan: 2 'sticky: 'e 'pady: 5)

;; Set initial values
(tk-set-var! 'gift "card")
(tk-set-var! 'sentmsg "")
(tk-set-var! 'statusmsg "")
(cbox 'set "Canada")
(show-pop-cmd)

;; Set event bindings
(tk/bind cbox '<<ComboboxSelected>> show-pop-cmd)
(tk/bind tk '<Return> send-gift-cmd)

(tk-event-loop tk)

