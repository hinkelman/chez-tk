(import (chez-tk))

(define tk (tk-start))

(tk/wm 'resizable tk 0 0)
(ttk-map-widgets 'all)

(define pb (tk 'create-widget 'progressbar))
(tk/grid pb 'row: 1 'columnspan: 5 'sticky: 'ew 'padx: 20 'pady: 10)

(let loop ([i 0])
  (cond [(> i 100) (display "Complete!\n")]
        [else (pb 'step 1)
              (sleep (make-time 'time-duration (flonum->fixnum 1e8) 0))
              (loop (add1 i))]))

(tk/destroy tk)
