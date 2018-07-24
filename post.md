I am making a sheet of address labels.
Here is my first iteration:

    \documentclass[letter,12pt]{article}
    
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
    \end{labels}
    
    \end{document}

Rather than manually writing all the labels in the body of the document, I wanted to store them in an external file. So I used the `textmerg` package, like in
[other](https://tex.stackexchange.com/questions/210885/how-to-print-addresses/)
[questions](https://tex.stackexchange.com/questions/256928/is-it-possible-to-add-dynamic-content/).

    \documentclass[letter,12pt]{article}
    
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
    \end{filecontents*}
    
    \begin{document}
    
    \Fields{\mylabel}
    
    \Merge{\jobname.dat}{%
      \addresslabel{
        \mylabel
      }%
    }%
    
    
    \end{document}

Unfortunately, the formatting has been disturbed in the switch.
Here is a comparison of the two:

<!-- TODO: add comparison -->

How can I get back the original dimensions?
