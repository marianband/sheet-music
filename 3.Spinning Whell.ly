\version "2.18.2"
\language "english"


tytul = \markup { \column 
                  { \vspace #0 \line \center-align { "SPINNING WHELL" }
%                    \vspace #0 \line \center-align { \smaller { "(гимн)" } } 
                  }
}
podtytul = "THE WOODSTOCK AQUARIAN BAND"
autor = \markup {  \column  
                   { \vspace #0 \line \right-align { "" } 
%                    \vspace #0 \line \right-align { "sł. Elżbieta Drożniewicz"} 
%                     \vspace #0 \line \right-align { "Eng. John Hendricks"}
                   }
}
%poet = "Janusz Stasiak"
poet = ""
%arranger = \markup { \vspace #1 \fontsize #0 "Słowa: Janusz Stasiak" }
%instrument = \markup { \fontsize #-3 "fortepianówka" }
instrument = ""

#(set-global-staff-size 14)
#(set-default-paper-size "a4")

date = #(strftime "%Y-%m-%d" (localtime (current-time)))
podpis = \markup {
      \fontsize #-5
      \override #'(word-space . 0)
      \line {
        \override #'(font-name . "Verdana") \line { "=^..^= " \date }
      }
}

\paper {
%  #(define dump-extents #t)
  indent = 8\mm 				% wcięcie
  line-width = 210\mm - 3 * 10\mm		% szerokosc nut
  ragged-right = ##f				% justowanie
  ragged-last-bottom = ##t			% justowanie ostatniej strony
%  force-assignment = #""
%  line-width = #(- line-width (* mm  3.000000))
%  system-separator-markup = \slashSeparator
  print-all-headers = ##t
  page-count = #1
  
 
  oddFooterMarkup = \markup {
    \column {
      \fill-line {
        \fontsize #-4 \override #'(font-name . "Vera Bold") \tytul
        \podpis
        \on-the-fly #print-page-number-check-first
        \line { \fontsize #-4 \override #'(font-name . "Vera Bold") { \fromproperty #'page:page-number-string "/ " \concat {\page-ref #'lastPage "0" "?"} } }
      }
    }
  }
  evenFooterMarkup = \markup {
    \column {
      \fill-line {
        \on-the-fly #print-page-number-check-first
        \line { \fontsize #-4 \override #'(font-name . "Vera Bold") { \fromproperty #'page:page-number-string "/ " \concat {\page-ref #'lastPage "0" "?"} } }
        \podpis
        \fontsize #-4 \override #'(font-name . "Vera Bold") \tytul
      }
    }
  }
}

% TRANSPOZYCJA!!!!!

trz = c
trdo = c

global = {
  \key fs \minor
  \time 4/4
  \tempo 4 = 110
  \override MultiMeasureRest #'expand-limit = #1
  \set Score.skipBars = ##f
  \override VerticalAxisGroup.remove-first = ##t
  
}
czesci = { 
  \once \override Score.RehearsalMark.self-alignment-X = #LEFT \mark \markup { \box \bold "I" }
  s1*2
  \once \override Score.RehearsalMark.self-alignment-X = #LEFT \mark \markup { \box \bold "1" }
  s1*17
  \once \override Score.RehearsalMark.self-alignment-X = #LEFT \mark \markup { \box \bold "2" }
  s1*17
  \once \override Score.RehearsalMark.self-alignment-X = #LEFT \mark \markup { \box \bold "B1" }
  s1*15
  \once \override Score.RehearsalMark.self-alignment-X = #LEFT \mark \markup { \box \bold "3" }
  s1*17
  \once \override Score.RehearsalMark.self-alignment-X = #LEFT \mark \markup { \box \bold "MOD" }
  s1*1
  \once \override Score.RehearsalMark.self-alignment-X = #LEFT \mark \markup { \box \bold "4" }
  s1*16
  \once \override Score.RehearsalMark.self-alignment-X = #LEFT \mark \markup { \box \bold "CODA" }
    
  
  
   
}

dynamicsPiano = \new Dynamics { 
  s2
%  \mark \markup { \italic "rit." }
}


chordNames = \chordmode {
  \global
  % Poniżej wpisz akordy. 
  R1
  e:7.9
  e1 a d g

  R1
  
  
}

melody = \relative c' {
  \global
  % Poniżej wpisz nuty.
  \autoBeamOn
  s1*2 \break
  s1*84
  
  \bar "|."
  \label #'lastPage
  
  
}

verse = \lyricmode { 
}

right = \relative c' {
  \global
  \autoBeamOn
  
  \bar "|." 
  \label #'lastPage
}

left = \relative c' {
  \global

  \bar "|." 
    
  
}

leadSheetPart = <<
  \new ChordNames \chordNames
  \new Staff \with {
  instrumentName = ""
  shortInstrumentName = ""
} { \melody }
%  \addlyrics { \verse }
>>

pianoPart = \new PianoStaff \with {
  instrumentName = ""
  shortInstrumentName = ""
} <<
  \new ChordNames \chordNames
  \new Staff = "right" \with {
    midiInstrument = "acoustic grand"
  } \right
%  \dynamicsPiano
  
%  \new Staff = "left" \with {
%    midiInstrument = "acoustic grand"
%  } { \clef bass \left }
>>

\score {
      \header {
      title = \markup { \fontsize #5 \tytul }
      subtitle = \podtytul
      composer = \autor
      poet = \poet
%      arranger = \arranger
      tagline = \podpis
      instrument = \instrument
    }
    
  <<
    \new Staff ="czesc" \with { \RemoveEmptyStaves } { \czesci }
    \transpose \trz \trdo { \leadSheetPart }
%    \transpose e e { \pianoPart }
    
  >>
    \layout {
      \context {
        \Staff %\RemoveEmptyStaves
%      	\override VerticalAxisGroup #'minimum-Y-extent = #'(-2 . 2)
        \override VerticalAxisGroup.remove-first = ##t
        \override MultiMeasureRest #'expand-limit = #1
      }
    }
    
  \midi {
    \global
%\tempo 4=140
  }
}

