I am making a sheet of address labels.
Here is my first iteration:

    \documentclass[letterpaper,12pt]{article}
    
    \usepackage[newdimens]{labels}
    \LabelCols=4
    \LabelRows=6
    \LeftPageMargin=20mm
    \RightPageMargin=20mm
    \TopPageMargin=13mm
    \BottomPageMargin=12.5mm
    \InterLabelColumn=8mm
    \InterLabelRow=5mm
    \LeftLabelBorder=0.2mm
    \RightLabelBorder=0.2mm
    \TopLabelBorder=0.2mm
    \BottomLabelBorder=0mm
    
    \LabelGridtrue % show grid for labels
    \LabelInfotrue % show info for labels
    
    \begin{document}
    
    \begin{labels}
    A
    
    B
    
    C
    
    D
    
    E
    
    F
    
    G
    
    H
    
    I
    
    J
    
    K
    
    L
    
    M
    
    N
    
    O
    
    P
    
    Q
    
    R
    
    S
    
    T
    
    U
    
    V
    
    W
    
    X
    \end{labels}
    
    \end{document}

Rather than manually writing all the labels in the body of the document, I wanted to store them in an external file. So I used the `textmerg` package, like in
[other](https://tex.stackexchange.com/questions/210885/how-to-print-addresses/)
[questions](https://tex.stackexchange.com/questions/256928/is-it-possible-to-add-dynamic-content/).

    \documentclass[letterpaper,12pt]{article}
    
    \usepackage{textmerg}
    
    \usepackage[newdimens]{labels}
    \LabelCols=4
    \LabelRows=6
    \LeftPageMargin=20mm
    \RightPageMargin=20mm
    \TopPageMargin=13mm
    \BottomPageMargin=12.5mm
    \InterLabelColumn=8mm
    \InterLabelRow=5mm
    \LeftLabelBorder=0.2mm
    \RightLabelBorder=0.2mm
    \TopLabelBorder=0.2mm
    \BottomLabelBorder=0mm
    
    \LabelGridtrue % show grid for labels
    \LabelInfotrue % show info for labels
    
    \usepackage{filecontents}
    
    \begin{filecontents*}{\jobname.dat}
    A
    B
    C
    D
    E
    F
    G
    H
    I
    J
    K
    L
    M
    N
    O
    P
    Q
    R
    S
    T
    U
    V
    W
    X
    \end{filecontents*}
    
    \begin{document}
    
    \Fields{\mylabel}
    
    \Merge{\jobname.dat}{%
      \addresslabel{
        \mylabel
      }%
    }%
    
    
    \end{document}

Unfortunately, the formatting has been disturbed in the switch. In particular, when I measure the column spacing with the Measure tool in Adobe Acrobat Reader DC, it comes to about 9.5 mm instead of 8 mm. This is a serious problem when printing onto sticky labels.

Here is a comparison of the two:

[![labels overlaid, red not matching black][1]][1]

The original is in black, the second in red.

How can I iterate over an external file while keeping the original dimensions?

(If there is a way to use `textmerg` for this, I would be fine with that, but a method with, say, `datatool` or `catchfile` would be fine too.)

Here is a link to a Github repo to try it yourself if you're curious:

https://github.com/nbeaver/textmerg-labels-example

**Edit:** pull request has been [submitted](https://github.com/rf-latex/textmerg/pull/1) and [accepted](https://github.com/rf-latex/textmerg/commit/615c8d390b5d5462ca37e54173d1943d8f3db83a).

  [1]: https://i.stack.imgur.com/emIuR.png