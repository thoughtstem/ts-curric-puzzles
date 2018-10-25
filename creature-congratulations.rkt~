#lang racket

(provide creature-congratulations)

;Good (various levels)
  ;Meta-cognitives
  ;Text
  ;Creature
  ;Meme
  ;New code snippet...
    ;New assets
    ;New shapes
    ;...



;Bad (various levels)
  ;Metacognitive feedback...
  ;


(require 2htdp/image
         ts-racket
         "./phrases.rkt")


(define bubble-color
  'black)

(define (render c)
  (define i
    (if (image? c)
        c
        (text c 24 'black)))
  
  (overlay
   i
   (rectangle (+ 50 (image-width i))
              (+ 50 (image-height i))
              'solid 'white)))

(define (bubble-render c)
  (define slanty  (triangle/sss 80 40 60 "solid" bubble-color))
  (define i (render c))
  (above/align "left"
   (overlay
    i
    (rectangle (+ 10 (image-width i))
               (+ 10 (image-height i))
               'solid
               bubble-color))
   slanty))

(define (talking-render c)
  (above/align "left"
               (beside (rectangle 50 1 'solid 'transparent)
                       (bubble-render c))
               (scale 0.5
                      (random-dude))))

;SHould this be here??
(define (creature-congratulations s)
  (talking-render s))


(module+ test
  (positive-phrase)
  (very-positive-phrase)
  (creature-congratulations "Hello"))


