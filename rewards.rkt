#lang racket

(provide positive-feedback)

(require 2htdp/image
         "./creature-congratulations.rkt"
         "./memes.rkt"
         "./phrases.rkt")


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

(define (creature top bottom)
  (creature-congratulations
   (~a top "\n\n" bottom "\n\nsrsly!!")))

(define fancy-fs
  (list
   xena
   fry
   picard
   creature))



(define (fancy-reward top bottom)
  (define fancy-f
    (list-ref fancy-fs (random (length fancy-fs))))
  
  (fancy-f top bottom))

(define (normal-reward top bottom)
  (text bottom 24 'black))

(define (positive-feedback score-history)
  ;Hmmm.  SHould we be checking here for the most recent score change?
  ;  Or do we assume that the caller did?
  ;  Or do we put in a contract to enforce it?
  
  (define total-questions (length score-history))
  (define current         (last score-history))

  (define top
    (~a "my " (opinion) "????"))
  
  (define bottom
    (~a (very-positive-phrase) "!!!"))

  (if (and (< 3 total-questions)
           (= 0 (remainder total-questions 3)))
      (fancy-reward top bottom)
      (normal-reward top bottom)))


(module+ test
  (positive-feedback '(0 1 2 3 4 4 3 4 4 5))
  (positive-feedback '(0 0 0 0 0 0))
  (positive-feedback '(0 0 0 0 0 0 0))
  )