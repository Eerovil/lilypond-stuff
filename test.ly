\version "2.24.4"

#(define (colored-notehead grob)
   "Creates a red circle behind a normal black notehead."
   (let* ((note (ly:note-head::print grob))
          (x-ext (ly:stencil-extent note X))
          (y-ext (ly:stencil-extent note Y))
          (cn-circle-color (ly:grob-property grob 'cn-circle-color))  ;; Read circleColor property
          (combo-stencil (ly:stencil-add
                          (
                            ly:stencil-translate
                            (
                              stencil-with-color
                              (make-circle-stencil 1 0.8 1)
                              cn-circle-color
                              )
                            (cons
                             (interval-center x-ext)
                             (interval-center y-ext))
                            )
                          note
                          )))
     (ly:make-stencil (ly:stencil-expr combo-stencil)
                      (ly:stencil-extent note X)
                      (ly:stencil-extent note Y))))


%% CUSTOM GROB PROPERTIES
%% I use "cn-" to keep my functions separate from standard
%% LilyPond functions (like a poor man's namespace).

% function from "scm/define-grob-properties.scm" (modified)
#(define (cn-define-grob-property symbol type?)
   (set-object-property! symbol 'backend-type? type?)
   (set-object-property! symbol 'backend-doc "custom grob property")
   symbol)

#(cn-define-grob-property 'cn-circle-color color?)

red-note = {
  \once \override NoteHead.cn-circle-color = #(x11-color "green")
  \once \override NoteHead.stencil = #colored-notehead
  \once \override NoteHead.layer = #-1
}
blue-note = {
  \once \override NoteHead.cn-circle-color = #blue
  \once \override NoteHead.stencil = #colored-notehead
  \once \override NoteHead.layer = #-1
}
% Apply different colors using simple functions
{ 
  \red-note c'2
  \blue-note d'4
  \blue-note d''8
  \blue-note d''
}
