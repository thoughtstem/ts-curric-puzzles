#lang racket

(provide tutorial)

(require 2htdp/image "quizzes.rkt")

(define (t s)
  (text s 24 'black))

(define q1 (question (t "What is bigger than 2 and less than 5?")
                     (must-equal (or/c 3 4)
                                 #:reward  (give-points 1)
                                 #:penalty (give-points -1))))
  
(define q2 (question (t "What is 2+2?")
                     (must-equal 4
                                 #:reward  (give-points 1)
                                 #:penalty (give-points -5))))
  
(define q3 (question (t "What is 3+1?")
                     (must-equal 4
                                 #:reward  (give-points 1)
                                 #:penalty (give-points -5))))


(define (tutorial)
  (start-quiz q1 q2 q3))
