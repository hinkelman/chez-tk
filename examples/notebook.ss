; PS/Tk Example Program "Notebook"
; Copyright (C) 2022 Daniil Archangelsky aka Kiky Tokamuro
; See the PS/Tk license for conditions of use.
; https://github.com/KikyTokamuro/guile-pstk/blob/main/examples/notebook.scm

(import (chez-tk))

(define tk (tk-start))

(tk/wm 'title tk "Notebook")
(tk/wm 'resizable tk 0 0)

(ttk-map-widgets 'all)
(ttk/set-theme "clam")

(let* ((notebook (tk 'create-widget 'notebook
		     'height: 200
		     'width: 200))
       (frame1 (tk 'create-widget 'frame))
       (label1 (frame1 'create-widget 'label
		       'text: "Page 1"
		       'font: "Hack 20"))
       (frame2 (tk 'create-widget 'frame))
       (label2 (frame2 'create-widget 'label
		       'text: "Page 2"
		       'font: "Hack 20")))
  (notebook 'add frame1 'text: "One" 'sticky: 'we)
  (notebook 'add frame2 'text: "Two" 'sticky: 'we)
  (tk/pack label1 label2)
  (tk/pack notebook)
  (tk-event-loop tk))
