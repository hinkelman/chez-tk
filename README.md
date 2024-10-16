# chez-tk

A Chez Scheme Interface to the Tk GUI Toolkit

Minor modification of [`(rebottled pstk)`](https://akkuscm.org/packages/(rebottled%20pstk)/) to work with Chez Scheme. 

## Requirements

`chez-tk` requires [Tcl/Tk](https://www.tcl.tk/software/tcltk/). The program `tclsh` is used by default, but `tk-start` takes an optional second argument to specify an alternative program, e.g., [`tclkit`](https://code.google.com/archive/p/tclkit/). `chez-tk` has only been tested on Linux.

## Installation

### Akku

```
$ akku install chez-tk
```

For more information on getting started with [Akku](https://akkuscm.org/), see this [blog post](https://www.travishinkelman.com/getting-started-with-akku-package-manager-for-scheme/).

## Usage and examples

Below is a simple example that will display `Hello world` in the REPL when the button is clicked.

```
(import (chez-tk))

(define tk (tk-start))
(tk/pack
  (tk 'create-widget 'button 'text: "Hello"
      'command: (lambda () (display "Hello world") (newline)))
  'padx: 20 'pady: 20)
(tk-event-loop tk)
```

See [here](https://github.com/hinkelman/chez-tk/tree/main/examples) for more examples that work with `chez-tk`. `(rebottled pstk)` has detailed [documentation](http://snow-fort.org/s/peterlane.info/peter/rebottled/pstk/1.7.0/index.html) that also applies to `chez-tk`. 
