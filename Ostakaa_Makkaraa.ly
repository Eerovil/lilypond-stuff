\version "2.24.4"
% automatically converted by musicxml2ly from Ostakaa_Makkaraa.mxl
\pointAndClickOff

\header {
    title =  "Ostakaa Makkaraa"
    encodingsoftware =  "MuseScore 3.6.2"
    encodingdate =  "2025-03-14"
    }

#(set-global-staff-size 20.0)
\paper {
    
    paper-width = 21.0\cm
    paper-height = 29.7\cm
    top-margin = 1.5\cm
    bottom-margin = 1.5\cm
    left-margin = 1.5\cm
    right-margin = 1.5\cm
    indent = 1.6153846153846154\cm
    short-indent = 1.2923076923076922\cm
    }
\layout {
    \context { \Score
        autoBeaming = ##f
        }
    }


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
  \once \override NoteHead.cn-circle-color = "#FF3131"
  \once \override NoteHead.stencil = #colored-notehead
  \once \override NoteHead.layer = #-1
}
yellow-note = {
  \once \override NoteHead.cn-circle-color = #(x11-color "yellow")
  \once \override NoteHead.stencil = #colored-notehead
  \once \override NoteHead.layer = #-1
}
green-note = {
  \once \override NoteHead.cn-circle-color = #(x11-color "green")
  \once \override NoteHead.stencil = #colored-notehead
  \once \override NoteHead.layer = #-1
}
blue-note = {
  \once \override NoteHead.cn-circle-color = "#1F51FF"
  \once \override NoteHead.stencil = #colored-notehead
  \once \override NoteHead.layer = #-1
}
orange-note = {
  \once \override NoteHead.cn-circle-color = #(x11-color "orange")
  \once \override NoteHead.stencil = #colored-notehead
  \once \override NoteHead.layer = #-1
}


PartPOneVoiceOne =  \relative e' {
    \clef "treble" \numericTimeSignature\time 4/4 \key c \major | % 1
    \orange-note \stemUp e2 \stemUp \yellow-note d2 | % 2
    \red-note c1 | % 3
    \orange-note \stemUp e2 \stemUp \yellow-note d2 | % 4
    \red-note c1 \break | % 5
    \red-note \stemUp c4 \red-note \stemUp c4 \red-note \stemUp c4 \red-note \stemUp c4 | % 6
    \yellow-note \stemUp d4 \yellow-note \stemUp d4 \yellow-note \stemUp d4 \yellow-note \stemUp d4 | % 7
    \orange-note \stemUp e2 \stemUp \yellow-note d2 | % 8
    \red-note c1 \bar "|."
    }

PartPOneVoiceFive =  \relative c {
    \clef "bass" \numericTimeSignature\time 4/4 \key c \major | % 1
    \red-note \stemUp c4 \stemDown c'4 \blue-note \stemUp g,4 \stemDown g'4 | % 2
    \red-note \stemUp c,4 \stemDown c'4 \red-note \stemUp c,4 \stemDown c'4 | % 3
    \red-note \stemUp c,4 \stemDown c'4 \blue-note \stemUp g,4 \stemDown g'4 | % 4
    \red-note \stemUp c,4 \stemDown c'4 \red-note \stemUp c,4 \stemDown c'4 \break | % 5
    \red-note \stemUp c,4 \stemDown c'4 \red-note \stemUp c,4 \stemDown c'4 | % 6
    \blue-note \stemUp g,4 \stemDown g'4 \blue-note \stemUp g,4 \stemDown g'4 | % 7
    \red-note \stemUp c,4 \stemDown c'4 \blue-note \stemUp g,4 \stemDown g'4 | % 8
    \red-note \stemUp c,4 \stemDown c'4 \red-note \stemDown <c, c'>2 \bar "|."
    }


% The score definition
\score {
    <<
        
        \new PianoStaff
        <<
            \set PianoStaff.instrumentName = "Piano"
            \set PianoStaff.shortInstrumentName = "Pno."
            
            \context Staff = "1" << 
                \mergeDifferentlyDottedOn\mergeDifferentlyHeadedOn
                \context Voice = "PartPOneVoiceOne" {  \PartPOneVoiceOne }
                >> \context Staff = "2" <<
                \mergeDifferentlyDottedOn\mergeDifferentlyHeadedOn
                \context Voice = "PartPOneVoiceFive" {  \PartPOneVoiceFive }
                >>
            >>
        
        >>
    \layout {}
    % To create MIDI output, uncomment the following line:
    %  \midi {\tempo 4 = 100 }
    }

