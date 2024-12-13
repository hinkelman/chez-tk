;; example comes from https://tkdocs.com/tutorial/morewidgets.html#listbox

(import (chez-tk))

(define country-codes '(ar au be br ca cn dk fi fr gr in it jp mx nl no es se ch))
(define country-names '(Argentina Australia Belgium Brazil Canada China Denmark
                                  Finland France Greece India Italy Japan Mexico
                                  Netherlands Norway Spain Sweden Switzerland))
(define pops '(41000000 21179211 10584534 185971537 33148682 1323128240 5457415 5302000
                        64102140 11147000 1131043000 59206382 127718000 106535000 16402414
                        4738085 45116894 9174082 7508700))
(define populations (map (lambda (cc pop) (cons cc pop)) country-codes pops))
(define gifts '(("card" "Greeting card") ("flowers" "Flowers") ("nastygram" "Nastygram")))

(define (show-pop idx-str country-codes country-names pops)
  (let* ([idx (string->number idx-str)]
	 [code (list-ref country-codes idx)]
	 [name (list-ref country-names idx)]
	 [popn (list-ref pops idx)])
    (format "The population of ~s (~s) is ~d" name code popn)))

(define (send-gift idx-str gift country-names gifts)
  (let* ([idx (string->number idx-str)]
	 [name (list-ref country-names idx)]
	 [g (cadr (assoc gift gifts))])
    (string-append "Sent " g " to leader of " (symbol->string name))))

(define show-pop-cmd
  (lambda ()
    (tk-set-var! 'sentmsg "")
    (tk-set-var!
     'statusmsg
     (show-pop (lbox 'curselection) country-codes country-names pops))))

(define send-gift-cmd
  (lambda ()
    (tk-set-var!
     'sentmsg
     (send-gift (lbox 'curselection) (tk-get-var 'gift) country-names gifts))))

(ttk-map-widgets 'all)
(define tk (tk-start))
(define c (tk 'create-widget 'frame 'padding: '(5 5 12 0)))
(define lbox (c 'create-widget 'listbox 'listvariable: (tk-var 'cnames) 'height: 5))
(tk-set-var! 'cnames country-names)
(define lbl (c 'create-widget 'label 'text: "Send to country's leader:"))
(define g1 (c 'create-widget 'radiobutton 'text: "Greeting card" 'variable: (tk-var 'gift) 'value: "card"))
(define g2 (c 'create-widget 'radiobutton 'text: "Flowers" 'variable: (tk-var 'gift) 'value: "flowers"))
(define g3 (c 'create-widget 'radiobutton 'text: "Nastygram" 'variable: (tk-var 'gift) 'value: "nastygram"))
(define send (c 'create-widget 'button 'text: "Send Gift" 'command: send-gift-cmd))
(define sentlbl (c 'create-widget 'label 'textvariable: (tk-var 'sentmsg) 'anchor: 'center))
(define status (c 'create-widget 'label 'textvariable: (tk-var 'statusmsg) 'anchor: 'w))

;; Grid all the widgets
(tk/grid c 'column: 0 'row: 0 'sticky: 'nwes)
(tk/grid lbox 'column: 0 'row: 0 'rowspan: 6 'sticky: 'nsew)
(tk/grid lbl 'column: 1 'row: 0 'padx: 10 'pady: 5)
(tk/grid g1 'column: 1 'row: 1 'padx: 20 'sticky: 'w)
(tk/grid g2 'column: 1 'row: 2 'padx: 20 'sticky: 'w)
(tk/grid g3 'column: 1 'row: 3 'padx: 20 'sticky: 'w)
(tk/grid send 'column: 2 'row: 4 'sticky: 'e)
(tk/grid sentlbl 'column: 1 'row: 5 'columnspan: 2 'sticky: 'n 'pady: 5 'padx: 5)
(tk/grid status 'column: 0 'row: 6 'columnspan: 2 'sticky: 'we)

;; Colorize alternating lines of the listbox
(define even-idx
  (filter (lambda (x) (= (remainder x 2) 0)) (iota (length country-names))))
(for-each (lambda (x) (lbox 'itemconfigure x 'background: "#f0f0ff")) even-idx)

;; Set initial values
(tk-set-var! 'gift "card")
(tk-set-var! 'sentmsg "")
(tk-set-var! 'statusmsg "")
(lbox 'selection 'set 4)
(show-pop-cmd)

;; Set event bindings
(tk/bind lbox '<<ListboxSelect>> show-pop-cmd)
(tk/bind lbox '<Double-1> send-gift-cmd)
(tk/bind tk '<Return> send-gift-cmd)

(tk-event-loop tk)

